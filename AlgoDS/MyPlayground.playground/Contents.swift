//: Playground - noun: a place where people can play

import Foundation
import DataStructSet


var bt = BinarySearchTree()
var root:Node<Int>?
//1,8,7,4,6,3,5,2
for i in [1,3,5,4,12,15,9,10] {
    root = bt.insertRec(root: root, value: i)
}
bt.inorderTraversalRec(root: root)
bt.inorderTraversal(root: root)
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


//var ht = HashTable<Dict<String, Int>>(count: 10)
//
//ht.update(value: Dict(k:"I", v: 1))
//ht.update(value: Dict(k:"am", v: 2))
//ht.update(value: Dict(k:"programmer", v: 3))
//ht.update(value: Dict(k:"artist", v: 4))
//ht.update(value: Dict(k:"swift", v: 7))
//ht.update(value: Dict(k:"mrigank", v: 8))
//ht.update(value: Dict(k:"java", v: 5))
//ht.update(value: Dict(k:"c++", v: 6))
//ht.update(value: Dict(k:"python", v: 7))
//ht.update(value: Dict(k:"haskel", v: 11))
//ht.update(value: Dict(k:"objc", v: 20))
//
//ht.update(value: Dict(k:"mrigank", v: 9))
//ht.update(value: Dict(k:"mrigank", v: 10))
//
//print(ht.value(key: "java"))
//print(ht.value(key: "swift"))
//print(ht.value(key: "objc"))
//print(ht.value(key: "c++"))
//ht.remove(key: "c++")
//print(ht.value(key: "c++"))

var ht = MapTable<Int, String>(count: 10)
ht.update(value: 1, key: "I")
ht.update(value: 2, key: "am")
ht.update(value: 3, key: "programmer")
ht.update(value: 4, key: "artist")
ht.update(value: 7, key: "swift")
ht.update(value: 8, key: "mrigank")
ht.update(value: 5, key: "java")
ht.update(value: 6, key: "c++")
ht.update(value: 7, key: "python")
ht.update(value: 11, key: "haskel")
ht.update(value: 20, key: "objc")
ht.update(value: 9, key: "mrigank")
ht.update(value: 10, key: "mrigank")


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
//print(quickSort(arr: &a, start: 0, end: a.count-1))
print(a)
a = [9,1,8,7,4,6,3,5,2,10]
insertionSort(arr: &a)
print(a)
a = [9,1,8,7,4,6,3,5,2,10]
selectionSort(arr: &a)
print(a)


a = [9,1,8,7,4,6,3,5,2,10]
var c = [5,6,8,10,7,6,4,3,2]
merge(arr: &c,left: 0, mid: 5,right: c.count-1)
print(c)
mergeSort(arr: &a, left: 0, right: a.count-1)
print(a)

var noHeap = [10,12,15,4,1,5,9,3]
buildHeap(arr: &noHeap)
noHeap = [7,1,2]
heapSort(arr: &noHeap)
print(noHeap)
heapify(arr: &noHeap, index: 0)

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
    print("trie \(k)")
}


trie.search(root: tRoot, val: ["a","b"], fullType: false)
trie.search(root: tRoot, val: ["a","b"], fullType: true)

trie.search(root: tRoot, val: ["a","b","d"], fullType: true)
trie.search(root: tRoot, val: ["a","b","g"], fullType: true)
trie.search(root: tRoot, val: ["a","b","g"], fullType: false)


var at = [3,4,1,2,6,7,9,8,10]

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
    var parent = (index-1)/2
    while index > 0 && arr[parent] < arr[index] {
        arr.swapAt(parent, index)
        index = parent
        parent = (index-1)/2
    }
}
insertInHeap(arr: &a, new: 20)
insertInHeap(arr: &a, new: 5)


//back to life
// 746. Min Cost Climbing Stairs

func minCostClimbingStairs(_ cost: [Int]) -> Int {
    let count = cost.count
    var f = [Int](repeating: 0, count: count)
    f[0] = cost[0]
    f[1] = cost[1]
    for i in 2..<count {
        f[i] = min(f[i-1], f[i-2]) + cost[i]
    }
    return min(f[count-1], f[count - 2])
}

minCostClimbingStairs([0,0,0,1])
minCostClimbingStairs([0,1,1,1])
minCostClimbingStairs([1,1,1,1])
minCostClimbingStairs([0,1,1,0])

func climbStairs(_ n: Int) -> Int {
    if n == 0 {
        return 0
    }
    if n == 1 {
        return 1
    }
    if n == 2 {
        return 2
    }
    var ways = [Int](repeating: 0, count: n+1)
    ways[0] = 0
    ways[1] = 1
    ways[2] = 2
    for i in 3...n {
        ways[i] = ways[i-1] + ways[i-2]
    }
    return ways[n]
}

climbStairs(2)
climbStairs(3)
climbStairs(4)
climbStairs(5)

///155: Min stack

class MinStack {

    var prim: Stack<Int> = Stack<Int>()
    var sec: Stack<Int> = Stack<Int>()

    /** initialize your data structure here. */
    init() {
        prim = Stack<Int>()
        sec = Stack<Int>()
    }
    
    func push(_ x: Int) {
        prim.push(x)
        sec.push(sec.top() == nil ? x : min(sec.top()!,x))
    }
    
    func pop() {
        prim.pop()
        sec.pop()
    }
    
    func top() -> Int {
        return prim.top()!
    }
    
    func getMin() -> Int {
        return sec.top()!
    }
}


var minStack = MinStack()
let arr = [2,8,94,8,4,8,6,9,1]
for i in arr {
    minStack.push(i)
}

for _ in 0..<arr.count {
    print(minStack.getMin())
    minStack.pop()
}


///931:  Minimum Falling Path Sum


func minFallingPathSum(_ A: [[Int]]) -> Int {
    
    var sum = [Int](repeating: 0, count: A[0].count)
    for i in 0..<A[0].count {
        sum[i] = A[0][i]
    }
    for i in 0..<A.count {
        for k in 0..<A[0].count {
            let first = i > 0 ? min(A[i][i-1], A[i][i]) : A[i][i]
            sum[i] = sum[i] + i < A[i].count-1 ? min(first,  A[i][i+1]) : first
        }
    }
    
    return 0
}

//TODO:
///96. Unique Binary Search Trees

/// 1. BST property is that all left items are smaller then root and all right elements are bigger.
/// 2. Goal is to get all unique BST, one way to achive is to get all unique tree when root is unique and add all of them.

//Number of binary search trees =
//(Number of ways root can be choosen)*
//(Number of Left binary search sub-trees) *
//(Number of Right binary search sub-trees)
/// 1,2,3,4,

/* if we need to calculate value for 4 as f(4)
 it would be all permutation of left * right side
 
 f(4) =  P(1) + P(2) + P(3) + P(4)
 f(4) =  f(0)*f(3) + f(1)*f(2) + f(2)*f(1) + f(0)*f(3)

 https://www.quora.com/Given-n-how-many-structurally-unique-BSTs-binary-search-trees-that-store-values-1-to-n-are-there-How-would-I-come-up-with-the-solution-Can-you-explain-the-thought-process-that-leads-to-the-solution
*/
func numTrees(_ n: Int) -> Int {
    var f = [Int](repeating: 0, count: n+1)
    f[0] = 1
    f[1] = 1
    
    for i in 2...n {
        for j in 1...i {
            f[i] = f[i] + f[i-j]*f[j-1]
        }
    }
    return f[n]
}

numTrees(4)
numTrees(5)
numTrees(6)

//Shortest Word Edit Path

func shortestWordEdit(_ target: String, _ source: String, _ given: [String]) -> Int {
    //find next element with distance unless array is empty or no element with distance one
    var found: (String, Int)? = (source, 0)
    while found != nil && found!.1 < given.count-1 {
        found = findNextWithDistanceOne(given, found!.0, found!.1)
        if found!.0 == target {
            return found!.1
        }
    }
    return -1
}
shortestWordEdit("dog", "bit", ["but", "put", "big", "pot", "pog", "dog", "lot"])

func findNextWithDistanceOne(_ array: [String], _ tar: String, _ start: Int) -> (String, Int)? {
    let chTar = Array(tar)
    for idx in start..<array.count {
        let nxt = array[idx]
        if nxt.count != tar.count || nxt == tar  { continue }
        var count = 0
        for (index, ch) in nxt.enumerated() {
            if ch != chTar[index] {
                count += 1
            }
            if count > 1 {
                continue
            }
        }
        if count == 1 { return (nxt, idx)}
    }
    return nil
}

findNextWithDistanceOne(["dog", "catw", "mat"], "sat", 0)



func bracketMatch(_ text: String) -> Int {
    let chArray = Array(text)
    var stack = Stack<Character>()
      if chArray.count == 1 {
        return 1
      }

      for nxt in text {
        if let top = stack.top() {
            if !matching(top, nxt) {
                stack.push(nxt)
            }else {
                stack.pop()
            }
        }else {
            stack.push(nxt)
        }
      }
    return stack.count()
}


func matching(_ br1: Character, _ br2: Character) -> Bool {
    if br1 == "(" && br2 == ")" {
        return true
    }else {
        return false
    }
}

bracketMatch("()(")
bracketMatch("()()")
bracketMatch("())(")


func defangIPaddr(_ address: String) -> String {
    return address.replacingOccurrences(of: ".", with: "[.]")
}

defangIPaddr("1.1.1.1")



/// Build binary search tree with nil values

func buildTree(_ arr: [Int?], index: Int) -> Node<Int>? {
    
    var node: Node<Int>?
    
    if let item = arr[index] {
        node = Node<Int>(data: item)
        let left = 2*index + 1
        if left < arr.count {
            node?.left = buildTree(arr, index: left)
        }
        let right = 2*index + 2
        if right < arr.count {
            node?.right = buildTree(arr, index: right)
        }
    }
    return node
}

let rootBuild = buildTree([1,2,3,nil,4,nil,5,nil,nil,6,7], index: 0)
let binary = BinaryTree()
binary.levelOrderTraversal(root: rootBuild)


// heap
// left = 2*i + 1
// right = 2*i + 2
// parent (i-1)/2 
func maxheapify(_ arr: inout [Int], index: Int) {
    
    let left = 2*index + 1
    let right = 2*index + 2
    if right > arr.count - 1 {
        return
    }
    let bigger = arr[left] > arr[right] ? left : right
    
    if arr[bigger] > arr[index] {
        arr.swapAt(bigger, index)
        maxheapify(&arr, index: bigger)
    }
}

func insert(arr: inout [Int], element: Int) {
    arr.append(element)
    
    var last = arr.count-1
    var parent = (last-1)/2
    
    while last > 0 && arr[parent] < arr[last] {
        arr.swapAt(last, parent)
        last = parent
        parent = (last-1)/2
    }
    
}




// fibnachi

func fibnachi(_ num: Int) -> Int {
    
    if num == 0 {
        return 0
    }
    if num == 1 {
        return 1
    }
    
    var fzero = 0
    var fone = 1
    var fnext = 0
    for _ in 2...num {
        fnext = fzero + fone
        fzero = fone
        fone = fnext
    }
    return fnext
}
fibnachi(6)
