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


//// Practice



let lruChe = LRUCache<Int>()
for indx in 1...14 {
    lruChe.insert(key: indx, value: indx)
}
lruChe.insert(key: 11, value: 11)
lruChe.head()
lruChe.search(key: 1)
lruChe.search(key: 8)
lruChe.head()


var cirarr = CircularArray<Int>()
for idx in 1...10 {
    cirarr.append(idx)
}
cirarr.itemAt(index: 7)
cirarr.circular(index: 3)
cirarr.rotate(shift: 3)
cirarr.itemAt(index: 7)
cirarr.remove(at: 1)
cirarr.itemAt(index: 1)
for _ in 1...9 {
    cirarr.removeLast()
}
//cirarr.itemAt(index: 0)





//func myAtoi(_ str: String) -> Int {
//    var char = [Character](str)
//    var valInt: Int = 128
//    if let valInt32 = char[0].unicodeScalars.first?.value {
//        valInt = numericCast(valInt32)
//    }
//    guard char[0] == "-" || char[0] == " " ||  48...57 ~= valInt else {
//        return 0
//    }
//
//    while <#condition#> {
//        <#code#>
//    }
//}

class StringSim {
    var heldString: String

    init(held: String){
        heldString = held
    }

    func display(){
        print(heldString)
    }

    func append(str: String){
        heldString.append(str)
    }
}
let myStr = StringSim(held:"Hello, playground")
var mySecStr = myStr
mySecStr.append(str: "foo")
myStr.display()
mySecStr.display()


struct MutableOne {
    var count = 1
    mutating func increment() {
        count += 1
    }
}

var test = MutableOne()
var test1 = test
test.increment()

print(test.count)
print(test1.count)

class C {}
let values: [Any]! = [C()]
let transformed = values.map { $0 as! [C] }

enum MyOp<Wrapped> {
    case some(_ has: Wrapped)
    case none

    @inlinable
    public func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U? {
        switch self {
        case .some(let y):
            return .some(try transform(y))
        case .none:
            return .none
        }
    }
}


