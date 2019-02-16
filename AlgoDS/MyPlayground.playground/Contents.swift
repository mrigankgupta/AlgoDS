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
merge(arr: &c,l:0,m:5,r:c.count-1)
print(c)
mergeSort(arr: &a, left: 0, right: a.count-1)
print(a)

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

//Leetcode
//108. Convert Sorted Array to Binary Search Tree

func sortedArrayToBST(_ nums: [Int]) -> Node<Int>? {
    if nums.count <= 0 {
        return nil
    }
    return makeBST(nums, start: 0, end: nums.count-1)
}

func makeBST(_ nums: [Int], start: Int, end: Int) -> Node<Int>? {
    if start > end {
        return nil
    }
    let mid: Int = start + (end - start)/2
    let root = Node<Int>(data: nums[mid])
    root.left = makeBST(nums, start: start, end: mid-1)
    root.right = makeBST(nums, start: mid+1, end: end)
    return root
}


let r1 = sortedArrayToBST([1,2,3,4,5,6,7,8,9])
let r2 = sortedArrayToBST([1,2,3,4,5,6,7,8,9,10])

//Leetcode
//100.Given two binary trees, write a function to check if they are the same or not.

func sameTree(root1: Node<Int>?, root2: Node<Int>?) -> Bool {

    if root1 == nil && root2 == nil { return true }
    if root1 != nil && root2 == nil { return false }
    if root1 == nil && root2 != nil { return false }

    let fst = sameTree(root1: root1?.left, root2: root2?.left)
    let scd = sameTree(root1: root1?.right, root2: root2?.right)
    return fst == true && scd == true && root1!.data == root2!.data
}

sameTree(root1: r1, root2: r2)

//Leetcode
//951. Flip Equivalent Binary Trees

func flipEquiv(root1: Node<Int>?, root2: Node<Int>?) -> Bool {

    if root1 == nil && root2 == nil { return true }
    if root1 != nil && root2 == nil { return false }
    if root1 == nil && root2 != nil { return false }

    let fst = flipEquiv(root1: root1?.left, root2: root2?.left)
    let scd = flipEquiv(root1: root1?.right, root2: root2?.right)
    let trd = flipEquiv(root1: root1?.left, root2: root2?.right)
    let frth = flipEquiv(root1: root1?.right, root2: root2?.left)
    return (fst == true || scd == true) && (trd == true || frth == true) && root1!.data == root2!.data
}

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

//Leetcode
//REDO
//92: Reverse a linked list from position m to n. Do it in one-pass.

func reverseBetween(_ head: SNode<Int>?, _ m: Int, _ n: Int) -> SNode<Int>? {
    if head == nil {
        return nil
    }
    var current = head
    var index = 1
    var prev: SNode<Int>?
    var next: SNode<Int>?
    //position before start of reverse
    var reversePrev: SNode<Int>?
    //position end of reverse
    var reversedEnd: SNode<Int>?
    if n-m >= 1 {
        while index < m {
            index += 1
            //
            reversePrev = current
            current = current?.next
        }
        reversedEnd = current
        //reverse list
        while index <= n {

            index += 1
            next = current?.next
            current?.next = prev

            prev = current
            current = next
        }

        reversedEnd?.next = current// join reverse end to last part
        reversePrev?.next = prev// join reverse end to the first part
        // return changed head if no node before reverse
        if reversePrev == nil {
            return prev
        }
    }

    return head
}
//leetcode
//19. Remove Nth Node From End of List

func removeNthFromEnd<T>(_ head: SNode<T>?, _ n: Int) -> SNode<T>? {
    if head == nil {
        return nil
    }
    var index = 0
    var current = head
    var nthPrev: SNode<T>?
    var nth: SNode<T>? = head

    while current != nil {
        if index >= n {
            nthPrev = nth
            nth = nth?.next
        }
        index += 1
        current = current?.next
    }

    nthPrev?.next = nth?.next
    if n == index {
        return head?.next
    }
    return head
}
//leetcode
//34. Find First and Last Position of Element in Sorted Array
//Given an array of integers nums sorted in ascending order, find the starting and ending position of a given target value.
//
//Your algorithm's runtime complexity must be in the order of O(log n).
//
//If the target is not found in the array, return [-1, -1].
//
//Example 1:
//
//Input: nums = [5,7,7,8,8,10], target = 8
//Output: [3,4]
//Example 2:
//
//Input: nums = [5,7,7,8,8,10], target = 6
//Output: [-1,-1]

func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    let result = [-1,-1]
    if nums.count < 0 {
        return result
    }
    let found = binarySearch(nums, 0, nums.count-1, target)
    if -1 != found {
        var left = found
        var right = found
        var leftExe = false
        var rightExe = false
        while left >= 0 && nums[left] == target {
            left -= 1
            leftExe = true
        }
        while right < nums.count && nums[right] == target {
            right += 1
            rightExe = true
        }
        return [leftExe ? left+1 : left, rightExe ? right-1 : right]
    }
    return result
}

func binarySearch(_ nums: [Int], _ start: Int, _ end: Int,_ target: Int) -> Int {
    if start > end {
        return -1
    }
    let mid = start + (end - start)/2

    if nums[mid] < target {
        return binarySearch(nums, mid+1, end, target)
    }else if nums[mid] > target {
        return binarySearch(nums, start, mid-1, target)
    }else {
        return mid
    }
}

//LeetCode
//81. Search in Rotated Sorted Array II
//REDO:
func searchRotated(_ nums: [Int], _ target: Int) -> Int {
    return binarySearchRotated(nums, 0, nums.count-1, target)
}

func binarySearchRotated(_ nums: [Int], _ start: Int, _ end: Int, _ target: Int) -> Int {
    if start > end {
        return -1
    }
    let mid = start + (end - start)/2
    if nums[mid] == target {
        return mid
    }else if nums[start] < nums[end] {
         if nums[mid] > target {
            return binarySearchRotated(nums, start, mid - 1, target)
        }else {
            return binarySearchRotated(nums, mid + 1, end, target)
        }
    }else {
        //rotated and center right
        if nums[mid] > nums[end]  {
            if target < nums[mid] && target >= nums[start] {
                return binarySearchRotated(nums, start, mid - 1, target)
            }else {
                return binarySearchRotated(nums, mid + 1, end, target)
            }
        }else {//rotated and center left
            if target > nums[mid] && target <= nums[end] {
                return binarySearchRotated(nums, mid + 1, end, target)
            }else {
                return binarySearchRotated(nums, start, mid - 1, target)
            }
        }
    }
}

searchRotated([5,6,7,8,1,2,3,4], 5)
//https://leetcode.com/problems/search-in-rotated-sorted-array/discuss/14435/Clever-idea-making-it-simple
func searchRotatedAwesome(_ nums: [Int], _ target: Int) -> Int {
    var lo = 0, hi = nums.count-1
    while (lo < hi) {
        let mid = (lo + hi) / 2
        print("low \(lo) high \(hi)")
        let num = (nums[mid] < nums[0]) == (target < nums[0])
            ? nums[mid]
            : target < nums[0] ? Int.min : Int.max

        if (num < target){
            lo = mid + 1
        }else if (num > target){
            hi = mid
        }else{
            return mid
        }
    }
    return -1
}
searchRotatedAwesome([5,6,7,8,1,2,3,4], 1)

//Leetcode
//11. Container With Most Water
//funda: search max bar on both side
//REDO:
func maxArea(_ height: [Int]) -> Int {
    var left = 0
    var right = height.count-1
    var maxArea = 0
    var dist = height.count-1
    while left < right {
        if height[left] >= height[right] {
            let current = height[right]*dist
            if maxArea < current {
                maxArea = current
            }
            right -= 1
        }else {
            let current = height[left]*dist
            if maxArea < current {
                maxArea = current
            }
            left += 1
        }
        dist -= 1
    }
    return maxArea
}


//leetcode
//96. Unique Binary Search Trees

func numTrees(_ n: Int) -> Int {
    var sum = 0
    return uniqueBST(1, n, &sum)
}

func uniqueBST(_ left: Int, _ right: Int,_ sum: inout Int) -> Int {
    if left >= right {
        return 1
    }
    var current = sum
    for i in left...right {
         current = uniqueBST(left, i-1, &current) + 1 + uniqueBST(i+1, right, &current)
    }
    return current
}

numTrees(3)

func numTreesDP(_ n: Int) -> Int {
    var G = [Int](repeating: 0, count: n+1);
    G[0] = 1
    G[1] = 1
    for i in 2...n {
        for j in 1...i {
            G[i] += G[j - 1] * G[i - j]
        }
    }
    return G[n]
}

numTreesDP(3)

//leetcode
//22. Generate Parentheses
//Brute Force
func brackets(num: Int) -> [[String]] {
    let initial = [["("],[")"]]
    if num == 1 {
        return initial
    }
    let combs = brackets(num: num - 1)
    var new = [[String]]()
    for comb in combs {
        for i in initial {
            var mutable = Array(comb)
            mutable.append(contentsOf: i)
            print(mutable)
            new.append(mutable)
        }
    }
    return new
}

brackets(num: 4)


//back tracking
//REDO:
func generatingPranthesis(num: Int) -> [[String]] {
    var list = [[String]]()
    var current = [String]()
    brackets(list: &list, current: &current, open: 0, close: 0, max: num)
    return list
}

func brackets(list: inout [[String]], current: inout [String] , open: Int, close: Int, max: Int) {
    if current.count >= 2*max {
        list.append(current)
        return
    }
    if open < max {
        var openAdded = current
        openAdded.append("(")
        brackets(list: &list, current: &openAdded, open: open+1, close: close, max: max)
    }

    if close < open {
        var closeAdded = current
        closeAdded.append(")")
        brackets(list: &list, current: &closeAdded, open: open, close: close+1, max: max)
    }
}

print(generatingPranthesis(num: 2))
//leetcode
//309. Best Time to Buy and Sell Stock with Cooldown
func maxProfitCoolDown(_ prices: [Int]) -> Int {
    return 0
}

//746. Min Cost Climbing Stairs
//leetcode
func minCostClimbingStairsBottomUp(_ cost: [Int]) -> Int {
    return minCost(cost, index: -1)
}

func minCost(_ cost: [Int], index: Int) -> Int {
    if cost.count <= 2 {
        return 0
    }
    if index >= cost.count-2 {
        return 0
    }
    //choose min from next and nextToNext cost
    return min(cost[index+1] + minCost(cost, index: index+1), cost[index+2] + minCost(cost, index: index+2))
}
minCostClimbingStairsBottomUp([1, 100, 1, 1, 1, 100, 1, 1, 100, 1])
minCostClimbingStairsBottomUp([10,15,20,1])
minCostClimbingStairsBottomUp([2,5,7,8,3,2,1,5,7,1,9])


func minCostClimbingStairsDP(_ cost: [Int]) -> Int {
    if cost.count <= 2 {
        return 0
    }
    var next = cost[0]
    var nextToNext = cost[1]
    var fn = 0
    for i in 2..<cost.count {
        fn = cost[i] + min(next, nextToNext)
        next = nextToNext
        nextToNext = fn
    }
    return min(next, nextToNext)
}
minCostClimbingStairsDP([1, 100, 1, 1, 1, 100, 1, 1, 100, 1])
minCostClimbingStairsDP([10,15,20,1])
minCostClimbingStairsDP([2,5,7,8,3,2,1,5,7,1,9])

//not coming correct
func minCostClimbingStairsTopDown(_ cost: [Int]) -> Int {
    return minCostTD(cost, index: cost.count-1)
}

func minCostTD(_ cost: [Int], index: Int) -> Int {
    if cost.count <= 2 {
        return 0
    }

    if index <= 1  { return 0 }

    return  min(cost[index] + min(minCostTD(cost, index: index-1),minCostTD(cost, index: index-2))
            , cost[index-1] + min(minCostTD(cost, index: index-2),minCostTD(cost, index: index-3)))
}

minCostClimbingStairsTopDown([1, 100, 1, 1, 1, 100, 1, 1, 100, 1])
minCostClimbingStairsTopDown([10,15,20,1])
minCostClimbingStairsTopDown([2,5,7,8,3,2,1,5,7,1,9])

//leetcode
//64. Minimum Path Sum
func minPathSumDP(_ grid: [[Int]]) -> Int {
    if grid.count == 0 {
        return 0
    }
    let row = grid.count
    let col = grid[0].count

    var memo = [[Int]](repeating: [Int](repeating: 0, count: col), count: row)
    for r in 0..<row {
        for c in 0..<col {
            if r==0 && c==0 {
                memo[r][c] = grid[r][c]
                continue
            }else if r == 0 {
                memo[r][c] = grid[r][c] + memo[r][c-1]
            }else if c == 0 {
                memo[r][c] = grid[r][c] + memo[r-1][c]
            }else{
                memo[r][c] = grid[r][c] + min(memo[r-1][c], memo[r][c-1])
            }
        }
    }
//    print(memo)
    return memo[row-1][col-1]
}
var grid = [[1,3,1],[1,5,1],[4,2,1]]
minPathSumDP(grid)
grid = [[1,2],[1,1]]
minPathSumDP(grid)


func minPathSumRec(_ grid: [[Int]], _ row: Int, _ col: Int) -> Int {
    if row==0 && col==0 {
        return grid[row][col]
    }else if row==0 {
        return grid[row][col] + minPathSumRec(grid, row, col-1)
    }else if col==0 {
        return grid[row][col] + minPathSumRec(grid, row-1, col)
    }else {
        return grid[row][col] + min(minPathSumRec(grid, row-1, col), minPathSumRec(grid, row, col-1))
    }
}
grid = [[1,3,1],[1,5,1],[4,2,1]]
minPathSumRec(grid, 2, 2)
grid = [[1,2],[1,1]]
minPathSumRec(grid, 1, 1)

//https://leetcode.com/problems/combination-sum/discuss/16502/A-general-approach-to-backtracking-questions-in-Java-(Subsets-Permutations-Combination-Sum-Palindrome-Partitioning)
//leetcode
//78. Subsets
/*
 test case [1,2,3]
                                        root
                        |------------------------|------------------------|
                        1                                                 [Empty]
            |-----------|-------------|                         |-----------|-------------|
            1,2                       1                         2                       [Empty]
|-------|-------|              |-------|-------|        |-------|-------|         |-------|-------|
1,2,3           1,2            1,3              1       2,3             2         3             [Empty]

 */
func powerSet(_ nums: [Int]) -> [[Int]] {
    var set = [[Int]]()
    var current = [Int]()
    subsets(nums, 0, &set, &current)
    return set
}

func subsets(_ nums: [Int], _ start: Int, _ set: inout [[Int]], _ current: inout [Int]) {
    if start > nums.count-1 {
        set.append(current)
        return
    }
    current.append(nums[start])
    subsets(nums, start+1, &set, &current)
    current.removeLast()
    subsets(nums, start+1, &set, &current)
}


func powerSetMethod2(_ nums: [Int]) -> [[Int]] {
    var set = [[Int]]()
    var current = [Int]()
    subsetsMethod2(nums, 0, &set, &current)
    return set
}

func subsetsMethod2(_ nums: [Int], _ start: Int, _ set: inout [[Int]], _ current: inout [Int]) {
    set.append(current)
    for i in start..<nums.count {// closed range for terminating condition as start become nums.count
        current.append(nums[i])
        subsetsMethod2(nums, i+1, &set, &current)// i+1 for avoiding infinite loop
        current.removeLast()
    }
}

powerSet([1,2,3])
powerSetMethod2([1,2,3])

//leetcode
//90. Subsets II
//Given a collection of integers that might contain duplicates, nums, return all possible subsets (the power set).
//
//Note: The solution set must not contain duplicate subsets.
//
//Example:
//
//Input: [1,2,2]
//Output:
//[
//[2],
//[1],
//[1,2,2],
//[2,2],
//[1,2],
//[]
//]
func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
    var list = [[Int]]()
    var current = [Int]()
    dupSet(nums.sorted(), 0, &list, &current)
    return list
}
func dupSet(_ nums: [Int], _ start: Int, _ list: inout [[Int]], _ current: inout [Int]) {
    list.append(current)

    for i in start..<nums.count {
        if i==start || nums[i-1] != nums[i] {//run only for these so to skip duplicate
            current.append(nums[i])
            dupSet(nums, i+1, &list, &current)
            current.removeLast()
        }
    }
}
subsetsWithDup([1,2,2])


//leetcode
//46. Permutations

func allPermutation(_ nums: [Int]) -> [[Int]] {
    return permute(nums, nums.count-1)
}

func permute(_ nums: [Int], _ end: Int) -> [[Int]] {
    if end <= 0 {
        return [[nums[0]]]
    }
    let prev = permute(nums, end-1)
    var new: [[Int]] = prev.map {
        var fo = [Int]($0)
        fo.append(nums[end])
        return fo
    }
    for item in new {
        for i in 0..<item.count-1 {
            var swaped = item
            swaped.swapAt(i, item.count-1)
            new.append(swaped)
        }
    }
    return new
}

allPermutation([1,2,3])

//leetcode
//47. Permutations II

func allPermutationNoDup(_ nums: [Int]) -> [[Int]] {
    return permuteNoDup(nums, nums.count-1)
}

func permuteNoDup(_ nums: [Int], _ end: Int) -> [[Int]] {
    if end <= 0 {
        return [[nums[0]]]
    }
    let prev = permuteNoDup(nums, end-1)

    var new: [[Int]] = prev.map {
        var fo = [Int]($0)
        fo.append(nums[end])
        return fo
    }
    for index in 0...new.count-1 {
        let current = new[index]
        let last = current.last
        for i in 0..<current.count-1 {
            if current[i] != last {
                var swaped = current
                swaped.swapAt(i, swaped.count-1)
                if !new.contains(swaped) {
                    new.append(swaped)
                }
            }
        }
    }
    return new
}

allPermutationNoDup([2,2,1,1])

//leetcode
/*Given a set of candidate numbers (candidates) (without duplicates) and a target number (target), find all unique combinations in candidates where the candidate numbers sums to target.
The same repeated number may be chosen from candidates unlimited number of times.
Note:
All numbers (including target) will be positive integers.
The solution set must not contain duplicate combinations.
Example 1:

Input: candidates = [2,3,6,7], target = 7,
A solution set is:
[[7],
[2,2,3]]
Example 2:

Input: candidates = [2,3,5], target = 8,
A solution set is:
[[2,2,2,2],
[2,3,3],
[3,5]]
*/
func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var comb = [[Int]]()
    var current = [Int]()

    allComb(candidates.sorted(), target, 0, &comb, &current, 0)
    return comb
}

func allComb(_ candidates: [Int], _ target: Int, _ sum: Int, _ comb: inout [[Int]],
             _ current: inout [Int], _ start: Int) {

    for i in start..<candidates.count {
        let item = candidates[i]
        if sum+item == target {
            current.append(item)
            comb.append(current)
            return
        }else if sum+item < target {
            var copy = current
            copy.append(item)
            allComb(candidates, target, sum + item, &comb, &copy, i)
        }
    }
}
combinationSum([2,3,6,7], 7)
combinationSum([3,1,2,4], 4)
combinationSum([2,3,5], 8)
combinationSum([2,4,8], 8)
combinationSum([4,2,8], 8)
// better method - backtracking, clean code
func combinationSumMethod2(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var comb = [[Int]]()
    var current = [Int]()
    allCombMethod2(candidates.sorted(), target, &comb, &current, 0)
    return comb
}

func allCombMethod2(_ candidates: [Int], _ target: Int, _ comb: inout [[Int]],
                    _ current: inout [Int], _ start: Int) {
    if target < 0 {
        return
    }else if 0 == target {
        comb.append(current)
        return
    }
    for i in start..<candidates.count {
        let item = candidates[i]
        current.append(item)
        allCombMethod2(candidates, target-item, &comb, &current, i)
        current.removeLast()
        // backtrack - basically for next combinations,
        //we are not taking this number in combination
    }
}
combinationSumMethod2([2,3,6,7], 7)
combinationSumMethod2([3,1,2,4], 4)
combinationSumMethod2([2,3,5], 8)
combinationSumMethod2([2,4,8], 8)
combinationSumMethod2([4,2,8], 8)


//40. Combination Sum II

func combinationSumII(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var comb = [[Int]]()
    var current = [Int]()
    allCombII(candidates.sorted(), target, 0, &comb, &current, 0)
    return comb
}

func allCombII(_ candidates: [Int], _ target: Int, _ sum: Int, _ comb: inout [[Int]], _ current: inout [Int], _ start: Int) {

    for i in start..<candidates.count {
        let item = candidates[i]
        if sum+item == target {
            current.append(item)
            comb.append(current)
            return
        }else if sum+item < target {
            //don't call for every repeated elements to avoid duplicates
            if i == start || ( i > start && candidates[i-1] != candidates[i]) {
                var copy = current
                copy.append(item)
                allCombII(candidates, target, sum + item, &comb, &copy, i+1)
            }
        }
    }
}
combinationSumII([2,3,6,7], 7)
combinationSumII([3,1,2,4], 4)
combinationSumII([2,3,5], 8)
combinationSumII([2,4,8], 8)
combinationSumII([10,1,2,7,6,1,5], 8)//sorted =1,1,2,5,6,7,10  result = [[1,2,5],[1,7],[1,1,6],[2,6]]
// better method - backtracking, clean code
func combinationSumIIMethod2(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var comb = [[Int]]()
    var current = [Int]()
    allCombIIMethod2(candidates.sorted(), target, &comb, &current, 0)
    return comb
}

func allCombIIMethod2(_ candidates: [Int], _ target: Int, _ comb: inout [[Int]], _ current: inout [Int], _ start: Int) {
    if 0 > target {
        return
    }else if 0 == target {
        comb.append(current)
        return
    }
    for i in start..<candidates.count {
        if  i > start && candidates[i-1] == candidates[i] {
            continue
        }
        let item = candidates[i]
        current.append(item)
        allCombIIMethod2(candidates, target - item, &comb, &current, i+1)
        current.removeLast()
    }
}

combinationSumIIMethod2([2,3,6,7], 7)
combinationSumIIMethod2([3,1,2,4], 4)
combinationSumIIMethod2([2,3,5], 8)
combinationSumIIMethod2([2,4,8], 8)
combinationSumIIMethod2([10,1,2,7,6,1,5], 8)//sorted =1,1,2,5,6,7,10  result = [[1,2,5],[1,7],[1,1,6],[2,6]]
//40. Combination Sum II
//leetcode
//return all combination subset arrays with a given sum
//Given an array of numbers, find subarray with sum to S
//print all combination with target sum
//recursion
func allCombinationSum(arr: [Int], target: Int) -> [[Int]] {
    var final: [[Int]] = []
    var current = [Int]()
    allCombination(result: &final, arr: arr.sorted(), index:0, target: target, current: &current)
    return final
}

func allCombination(result: inout [[Int]], arr:[Int], index: Int, target: Int, current: inout [Int]) {
    if index > arr.count-1  {
        if target == 0 {
            result.append(current)
        }
        return
    }
    if target == 0 {
        result.append(current)
         allCombination(result: &result, arr: arr, index: index+1, target: target, current: &current)
    }else {
        allCombination(result: &result, arr: arr, index: index+1, target: target, current: &current)
        var copy = current
        copy.append(arr[index])
        allCombination(result: &result, arr: arr, index: index+1, target: target-arr[index], current: &copy)
    }
}

allCombinationSum(arr: [1,4,6,2,5,7,8,1], target: 14)
allCombinationSum(arr: [1,1,2,3,6,7], target: 7)
allCombinationSum(arr: [1,4,6,2,5,7,8,20], target: 10)
allCombinationSum(arr: [10,1,2,7,6,1,5], target: 8)
allCombinationSum(arr: [1,1,2,5,6,7,10], target: 8)

//leetcode
//416. Partition Equal Subset Sum
func partition(_ start: Int, _ left: [Int], _ right: [Int],
               _ leftSum: Int, _ rightSum: Int, _ nums: [Int], _ sucess: inout Bool) {
    if leftSum == rightSum {
        print(leftSum, rightSum)
        print(left,right)
        sucess = true
        return
    }

    for index in start..<nums.count {
        var leftCopy = left
        leftCopy.append(nums[index])
        var rightCopy = Set(right)
        rightCopy.remove(nums[index])
        partition(index+1, leftCopy,Array(rightCopy), leftSum+nums[index], rightSum-nums[index], nums, &sucess)
    }

}
func canPartition(_ nums: [Int]) -> Bool {
    var sum = 0
    for i in nums {
        sum = sum + i
    }
    let left = [Int]()
    let copy = nums
    var success = false
    partition(0, left, copy, 0, sum, nums, &success)
    return success
}

canPartition([1, 5, 11, 5])
canPartition([2,2,3,5])
canPartition([1,2,3,4,5,6,7])
//canPartition([100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100])
//0/1 Knapsack
//Given weights and values of n items, put these items in a knapsack of capacity W to get the
//maximum total value in the knapsack.
//Doing by combinatorial way, checking each combination and then computing if this is max ~ bruteforce
func maxValCombination(_ target: Int, _ indices: inout [Int], _ index: Int,
                       _ maxSoFar: inout Int, _ val: [Int], _ weight: [Int] ) {

    if target == 0 || index < 0 {
        if target >= 0 {
            var sum = 0
            for index in indices {
                sum += val[index]
            }
            if sum > maxSoFar {
                maxSoFar = sum
            }
        }
        return
    }
    if weight[index] > target {
        maxValCombination(target, &indices, index-1, &maxSoFar, val, weight)
    }else {
        var copy = indices
        copy.append(index)
        maxValCombination(target - weight[index], &copy, index-1, &maxSoFar, val, weight)
        maxValCombination(target, &indices, index-1, &maxSoFar, val, weight)
    }
}
var indices = [Int]()
var maxSoFar = 0
maxValCombination(6, &indices, 4, &maxSoFar, [5,3,5,3,2], [1,2,4,2,5])
print(maxSoFar)
maxValCombination(50, &indices, 2, &maxSoFar, [60,100,120], [10,20,30])
print(maxSoFar)

// breaking problem into subproblem, improving and preparing it for DP
func maxVal(_ target: Int, _ index: Int, _ val: [Int], _ weight: [Int] ) -> Int {
    if target == 0 || index == -1 {// index should be -1 for base case as index 0 is to be computed
        return 0
    }
    if weight[index] > target {
        return maxVal(target, index-1, val, weight)
    }else{
        return max(maxVal(target - weight[index], index-1, val, weight) + val[index], maxVal(target, index-1, val, weight))
    }
}

maxVal(50, 2, [60,100,120], [10,20,30])
maxVal(6, 4, [5,3,5,3,2], [1,2,4,2,5])

// improve further, memoizing
func maxValDP(_ target: Int, _ val: [Int], _ weight: [Int]) -> Int {
    var memo = [[Int]](repeating: [Int](repeating: 0, count:target+1 ), count: val.count)
        for i in 0...val.count-1 {
            for w in 0...target {

            if target == 0 || i == 0 {
                memo[i][w] = 0
            }else if weight[i-1] <= w {
                memo[i][w] = max(val[i-1] + memo[i-1][w-weight[i-1]], memo[i-1][w])
            }else{
                memo[i][w] = memo[i-1][w]
            }
        }
    }
    return memo[val.count-1][target]
}

maxValDP(50, [60,100,120], [10,20,30])
maxValDP(6, [5,3,5,3,2], [1,2,4,2,5])
//TODO:
func bracketSum(_ num: [String], _ index: Int, _ sum: inout Int, _ forward: Bool, _ lastBacktrack: Int) {
    if index <= 0 && forward == false {
        return
    }
    if forward == true {
        if index >= num.count {
            bracketSum(num, index-2, &sum, false, lastBacktrack)
        }else if num[index] == "]" {
            bracketSum(num, index-1, &sum, false, index)
        }else {
            bracketSum(num, index+1, &sum, true, lastBacktrack)
        }
    }else{
        if num[index] == "[" {
            bracketSum(num, lastBacktrack+1, &sum, true, 0)
        }else {
            print(num[index])
            var new = sum + Int(num[index])!
            bracketSum(num, index-1, &new, false, lastBacktrack)
        }
    }

}

func solveBracketSum(_ num: [String]) -> Int {
    var sum = 0
    bracketSum(num, 0, &sum, true, 0)
    return sum
}

//print(solveBracketSum(["[","1","[","2","3","]","[","4","5","6","]","]"]))
//leetcode
//114. Flatten Binary Tree to Linked List
//REDO:
var flt = BinaryTree()
var fltRoot: Node<Int>?

for i in [1,2,5,3,4,100,6] {
    fltRoot = flt.levelOrderInsert(root: fltRoot, data: i)
}

func flatten(_ root: Node<Int>?) {
    insertFlat(root)
}
 var prev: Node<Int>?
func insertFlat(_ root: Node<Int>?) {
    if root == nil {
        return
    }
    insertFlat(root?.right)
    insertFlat(root?.left)
    root?.right = prev
    root?.left = nil
    prev = root
}
flatten(fltRoot)
print(flt.height(fltRoot))

flt.levelOrderTraversalEfficient(root: fltRoot)
//leetcode REDO:
//17. Letter Combinations of a Phone Number

func letterCombinations(_ digits: String) -> [String] {
    let map: [[Character]] = [["a","b","c"],["d","e","f"],["g","h","i"],["j","k","l"],
                ["m","n","o"],["p","q","r","s"],["t","u","v"],["w","x","y","z"]]
    let numArr = digits.utf8.map { Int($0) - 48 }
    var final = [String]()
    phoneComb(map, numArr, numArr.count-1, [], &final)
    return final
}

func phoneComb(_ map: [[Character]],  _ digits:[Int], _ count: Int,
               _ combination: [Character], _ final:inout [String]) {
    if count < 0 {
        final.append(String(combination))
        return
    }
    let num = digits[count]
    let items = map[num-2]
    var copy = combination
    for item in items {
        copy.append(item)
        phoneComb(map, digits, count - 1, copy, &final)
        copy.removeLast()
    }
}

letterCombinations("23")
//leetcode
//8. String to Integer (atoi)

func myAtoi(_ str: String) -> Int {
    var neg = false
    var num = 0
    var i = 0
    for ch in str.reversed() {
        let val = charToInt(String(ch))

        if val > -1 {
            let exponent = pow(10, Double(i))
            if exponent > Double(Int.max) {
                return Int.max
            }else if exponent < Double(Int.min) {
                return Int.min
            }
            num = num + val*Int(exponent)
            i += 1
        }else if num > 0 {
            if ch == "-" {
                neg = true
                continue
            }else if ch == " " { // white space
                continue
            }else { // other then number so exit
                return 0
            }
        }else {
            if val == -1 {//trailing char is not whitespace or neg so ignore
                continue
            }else if ch == "-" {
                neg = true
                continue
            }
        }
    }
    if neg == true {
        num = -num
    }
    return num
}

func charToInt(_ str: String) -> Int {
    let val = str.utf8.map{ Int($0)}
    if 48...57 ~= val[0] {
        return val[0] - 48
    }
    return -1
}
myAtoi("23")
myAtoi("words and 987")
myAtoi("4193 with words")
myAtoi("   -42")

myAtoi("-00000000000000000000000000001")

//leetcode
//198. House Robber

func rob(_ nums: [Int]) -> Int {
    return maxRob(nums, nums.count-1)
}

func maxRob(_ nums: [Int], _ index: Int) -> Int {
    if index == 0 {
        return nums[0]
    }else if index == 1 {
       return max(nums[0], nums[1])
    }else if index == 2 {
        return max(nums[1], nums[0]+nums[2])
    }

    return max(nums[index]+maxRob(nums, index-2), maxRob(nums, index-1))
}

rob([2,7,9,3,1])
rob([1,1])

func robDP(_ nums: [Int]) -> Int {
    let count = nums.count-1
    if count < 0 {
        return 0
    }
    var maxRb = [Int](repeating: 0, count: count+1)

    if count == 0 {
        maxRb[0] = nums[0]
        return maxRb[0]
    }else if count == 1 {
        maxRb[1] = max(nums[0], nums[1])
        return maxRb[1]
    }else if count == 2 {
        maxRb[2] = max(nums[1], nums[0]+nums[2])
        return maxRb[2]
    }else {
        maxRb[0] = nums[0]
        maxRb[1] = max(nums[0], nums[1])
        maxRb[2] = max(nums[1], nums[0]+nums[2])
    }

    for index in 3...count {
      maxRb[index] = max(nums[index]+maxRb[index-2], maxRb[index-1])
    }
    return maxRb[count]
}

robDP([2,7,9,3,1])
robDP([1,1])
//leetcode
//152. Maximum Product Subarray
//brute force
func maxProduct(_ nums: [Int]) -> Int {
    let count = nums.count-1
    var max = 0
    for i in 0...count {
        var d = 0
        for _ in i...count {
            var current = 1
            for k in i...count-d {
                current = current*nums[k]
            }
            if current > max {
                max = current
            }
            d += 1
        }

    }
    return max
}

maxProduct([5,0,1,2,-3,-2,-31])

//func maxProductDP(_ nums: [Int]) -> Int {
//    if nums.count <= 0 {
//        return 0
//    }
//    var maxSofar = nums[0]
//    var maxCon = nums[0]
//    var minCon = nums[0]
//    for i in 1..<nums.count {
//        maxCon = max(nums[i],maxCon*nums[i])
//        minCon = min(nums[i],minCon*nums[i])
//        maxSofar = max(maxSofar, max(maxCon, minCon))
//    }
//    return maxSofar
//}

func maxProductDP(_ nums: [Int]) -> Int {
    if nums.count <= 0 {
        return 0
    }
    var maxSofar = nums[0]
    var maxCont = nums[0]// continious maximum till now
    var minCont = nums[0]// continious minimum till now
    for i in 1..<nums.count {
        let lastMaxCont = maxCont
        maxCont = max(nums[i],max(nums[i]*maxCont, nums[i]*minCont))
        minCont = min(nums[i],min(nums[i]*lastMaxCont, nums[i]*minCont))
        maxSofar = max(maxSofar, maxCont)
    }
    return maxSofar
}

maxProductDP([5,0,1,2,-3,-2,-31])
maxProductDP([5,0,1,2,-3])
maxProductDP([5,0,1,2,-3,-2])

maxProductDP([5,0])
maxProductDP([0,5])


//628. Maximum Product of Three Numbers
//O(nlogn)
func maximumProductThree(_ nums: [Int]) -> Int {
    let count = nums.count
    if count == 3 {
        return nums[0]*nums[1]*nums[2]
    }
    var sorted = nums.sorted()
    let first = sorted[0]*sorted[1]*sorted[count-1]
    let sec = sorted[count-1]*sorted[count-2]*sorted[count-3]
    if sec > first {
        return sec
    }else{
        return first
    }
}
//O(n)
func maximumProductThreeN(_ nums: [Int]) -> Int {
    var min1 = Int.max
    var min2 = Int.max

    var max1 = Int.min
    var max2 = Int.min
    var max3 = Int.min

    for item in nums {
        if item < min1 {
            min2 = min1
            min1 = item
        }else if item < min2 {
            min2 = item
        }

        if item > max1 {
            max3 = max2
            max2 = max1
            max1 = item
        }else if item > max2 {
            max3 = max2
            max2 = item
        }else if item > max3 {
            max3 = item
        }
    }
    let first = min1*min2*max1
    let sec = max1*max2*max3
    if sec > first {
        return sec
    }else{
        return first
    }

}

maximumProductThree([1,2,3,4])
maximumProductThree([722,634,-504,-379,163,-613,-842,-578,750,951,-158,30,-238,-392,-487,-797,-157,-374,999,-5,-521,-879,-858,382,626,803,-347,903,-205,57,-342,186,-736,17,83,726,-960,343,-984,937,-758,-122,577,-595,-544,-559,903,-183,192,825,368,-674,57,-959,884,29,-681,-339,582,969,-95,-455,-275,205,-548,79,258,35,233,203,20,-936,878,-868,-458,-882,867,-664,-892,-687,322,844,-745,447,-909,-586,69,-88,88,445,-553,-666,130,-640,-918,-7,-420,-368,250,-786])
maximumProductThreeN([1,2,3,4])
maximumProductThreeN([722,634,-504,-379,163,-613,-842,-578,750,951,-158,30,-238,-392,-487,-797,-157,-374,999,-5,-521,-879,-858,382,626,803,-347,903,-205,57,-342,186,-736,17,83,726,-960,343,-984,937,-758,-122,577,-595,-544,-559,903,-183,192,825,368,-674,57,-959,884,29,-681,-339,582,969,-95,-455,-275,205,-548,79,258,35,233,203,20,-936,878,-868,-458,-882,867,-664,-892,-687,322,844,-745,447,-909,-586,69,-88,88,445,-553,-666,130,-640,-918,-7,-420,-368,250,-786])
