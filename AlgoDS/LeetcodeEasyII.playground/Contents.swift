import DataStructSet
import Foundation
//437. Path Sum III

func pathSum(_ root: Node<Int>?, _ target: Int) -> Int {
    var freq = 0
    var stack = Stack<Node<Int>>()
    stack.push(root!)
    while stack.count() > 0 {
        let next = stack.pop()
        sum(next, 0, target, &freq)
        if let left = next?.left {
            stack.push(left)
        }
        if let right = next?.right {
            stack.push(right)
        }
    }
    return freq
}

func sum(_ root: Node<Int>?, _ current: Int, _ target: Int, _ freq: inout Int) {
    if root == nil {
        return
    }
    var now = current
    now += root!.data
    if now == target {
        freq += 1
    }
    sum(root?.left, now, target, &freq)
    sum(root?.right, now, target, &freq)
}

var pathBT = BinaryTree()
var rootPBT = pathBT.buildTree(0, [10,5,-3,3,2,nil,11,3,-2,nil,1,nil,nil])
pathSum(rootPBT, 8)

rootPBT = pathBT.buildTree(0, [5,4,8,11,nil,13,4,7,2,nil,nil,5,1])
pathSum(rootPBT, 22)

rootPBT = pathBT.buildTree(0, [-2,nil,-3])
pathSum(rootPBT, -5)

rootPBT = Node(data: 1)
rootPBT?.right = Node(data: 2)
rootPBT?.right?.right = Node(data: 3)
rootPBT?.right?.right?.right = Node(data: 4)
rootPBT?.right?.right?.right?.right = Node(data: 5)
pathSum(rootPBT, 5)
rootPBT = Node(data: 2)
pathSum(rootPBT, 2)

rootPBT = pathBT.buildTree(0, [1,-2,-3,1,3,-2,nil,-1])
pathSum(rootPBT, -1)

/*
 https://leetcode.com/problems/path-sum-iii/discuss/91888/18ms-Fast-One-Pass-C%2B%2B-Solution
 Algo for Path sum while going recursively downward
 target = 6
       1
     /   \
    2      3
   / \    / \
  4   5  6   7
 1. While traversing binary tree, modifiy tree as such that this node's value is sum of all ancestors' values.
        1
      /   \
     3     4
    / \   /  \
   7   8 10  11
 2. Store those values in a dictionary as frequency, while traversing
 3. If dictionary[current_sum - target] is presented, means that sum can be equal to target.
 for example: while at node 4, dict[1] = 1, dict[3] = 1,
   dict[7-6] is presented so 7 - 1 = 6
 
 */

func pathSumAwesome(_ root: Node<Int>?, _ target: Int) -> Int {
    
    var dict = [Int: Int]()
    var count = 0
    pathNode(root, target, &dict, &count, 0)
    return count
}

func pathNode(_ root: Node<Int>?, _ target: Int, _ dict: inout [Int: Int],
              _ count: inout Int, _ prev: Int) {
    guard let nroot = root else {
        return
    }
    nroot.data += prev
    if nroot.data == target {
        count += 1
    }
    count += dict[nroot.data-target] ?? 0
    dict[nroot.data, default: 0] += 1
    pathNode(nroot.left, target, &dict, &count, nroot.data)
    pathNode(nroot.right, target, &dict, &count, nroot.data)
    dict[nroot.data, default: 0] -= 1
}

pathSumAwesome(rootPBT, -1)
rootPBT = pathBT.buildTree(0, [5,4,8,11,nil,13,4,7,2,nil,nil,5,1])
pathSumAwesome(rootPBT, 22)

rootPBT = pathBT.buildTree(0, [-2,nil,-3])
pathSumAwesome(rootPBT, -5)

//617. Merge Two Binary Tree

func mergeTrees(_ t1: Node<Int>?, _ t2: Node<Int>?) -> Node<Int>? {
    
    return merge(t1, t2, nil, false)
}


func merge(_ t1: Node<Int>?, _ t2: Node<Int>?, _ prev1: Node<Int>?, _ left: Bool) -> Node<Int>? {
    
    if t1 == nil && t2 == nil {
        return nil
    }
    var newPrev = t1
    if t1 == nil && t2 != nil {
        let new = Node<Int>(data: t2!.data)
//        print(new.data)
        if prev1 != nil {
            if left {
                prev1?.left = new
            }else {
                prev1?.right = new
            }
        } else {
            print("never")
//            newPrev = new
        }
        newPrev = new
    }
    t1?.data += t2?.data ?? 0

    merge(t1?.left, t2?.left, newPrev, true)
    merge(t1?.right, t2?.right, newPrev, false)
    return t1 == nil ? newPrev : t1
}

let mergeBT = BinaryTree()
var t1 = mergeBT.buildTree(0, [1,3,2,5,nil])
var t2 = mergeBT.buildTree(0, [2,1,3,nil,4,nil,7])

mergeBT.inorderTraversal(root: mergeTrees(t1, t2))
t1 = mergeBT.buildTree(0, [1])
t2 = mergeBT.buildTree(0, [nil])
mergeBT.inorderTraversal(root: mergeTrees(t1, t2))

t1 = mergeBT.buildTree(0, [nil])
t2 = mergeBT.buildTree(0, [1])
mergeBT.inorderTraversal(root: mergeTrees(t1, t2))

t1 = mergeBT.buildTree(0, [1,2,nil,3])
t2 = mergeBT.buildTree(0, [1,nil,2,nil,nil,nil,3])
mergeBT.levelOrderTraversal(root: mergeTrees(t1, t2))

t1 = mergeBT.buildTree(0, [1,2,3,4])
t2 = mergeBT.buildTree(0, [nil,nil])
print("shit")
mergeBT.preorderTraversal(root: mergeTrees(t1, t2))

//1122. Relative Sort Array

func relativeSortArray(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
    
    var dict = [Int: Int]()
    for item in arr1 {
        if let exist = dict[item] {
            dict[item] = exist + 1
        }else {
            dict[item] = 1
        }
    }
    var new = [Int]()
    for item in arr2 {
        if let freq = dict[item] {
            for i in 0..<freq {
                new.append(item)
            }
            dict[item] = nil
        }
    }
    let rest = dict.sorted { $0.key < $1.key }.map { $0.key }
    for item in rest {
        if let freq = dict[item] {
            for i in 0..<freq {
                new.append(item)
            }
            dict[item] = nil
        }
    }
    return new
}

relativeSortArray([2,3,1,3,2,4,6,7,9,2,19], [2,1,4,3,9,6])

//914. X of a Kind in a Deck of Cards


func hasGroupsSizeX(_ deck: [Int]) -> Bool {

    let valueArr = deck.reduce(into: [Int: Int]()) { (dict, item) in
        dict[item, default: 0] += 1
    }.sorted{ $0.value < $1.value }.map { $0.value }
    let divs = divisors(valueArr[0])
    for div in divs {
        var count = 0
        for value in valueArr {
            if (value % div == 0) {
                count += 1
            }
        }
        if count == valueArr.count {
            return true
        }
    }
    
    return false
}

func divisors(_ num: Int) -> [Int] {
    if num < 2 {
        return[]
    }
    var divisors = [Int]()
    for div in 2...num {
        if num%div == 0 {
            divisors.append(div)
        }
    }
    return divisors
}

//divisors(7)
//divisors(14)
//divisors(28)
//
hasGroupsSizeX([1,2,3,4,4,3,2,1])
hasGroupsSizeX([1,1,1,2,2,2,3,3])
//
hasGroupsSizeX([1,1])
hasGroupsSizeX([1])
hasGroupsSizeX([1,1,2,2,2,2])

hasGroupsSizeX([1,1,2,2,2,2])
hasGroupsSizeX([1,1,1,1,2,2,2,2,2,2])
hasGroupsSizeX([1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3])


//276. Paint Fence

//func numWays(_ n: Int, _ k: Int) -> Int {
//
//}

func permute(_ nums: [Int]) -> [[Int]] {
    return permutePartial(nums, nums.count-1)
}

func permutePartial(_ nums: [Int], _ end: Int) -> [[Int]] {
    if end == 0 {
        return [[nums[0]]]
    }
    
    let prev = permutePartial(nums, end-1)
    var new = [[Int]]()
    for var item in prev {
        item.append(nums[end])
        new.append(item)
    }
    
    for item in new {
        for i in 0..<item.count-1 {
            var swap = item
            swap.swapAt(item.count-1, i)
            new.append(swap)
        }
    }
    return new
}

permute([1,2])
permute([1,2,3])



func permuteUnique(_ nums: [Int]) -> [[Int]] {
    return permuteUniqPartial(nums, nums.count-1)
}

func permuteUniqPartial(_ nums: [Int], _ end: Int) -> [[Int]] {
    if end == 0 {
        return [[nums[0]]]
    }
    
    let prev = permuteUniqPartial(nums, end-1)
    var new = Set<[Int]>()
    for var item in prev {
        item.append(nums[end])
        new.insert(item)
    }
    
    for item in new {
        for i in 0..<item.count-1 {
            var swap = item
            swap.swapAt(item.count-1, i)
            new.insert(swap)
        }
    }
    return new.map{ $0 }
}

permuteUnique([1,1,2])
permuteUnique([2,2,1,1])


func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var combAll = [[Int]]()
    var combCur = [Int]()
    combi(candidates.sorted(), target, &combAll, &combCur, 0, 0)
    return combAll
}

func combi(_ arr: [Int], _ target: Int, _ combAll: inout [[Int]],
           _ combCur: inout [Int], _ current: Int, _ start: Int) {
    if current > target {
        return
    }else if current == target {
        combAll.append(combCur)
    }
    
    for i in start..<arr.count {
        if i == start || arr[i] != arr[i-1] {
            combCur.append(arr[i])
            combi(arr, target, &combAll, &combCur, current + arr[i], i+1)
            combCur.removeLast()
        }
    }
}
combinationSum([2,3,6,7], 7)
combinationSum([10,1,2,7,6,1,5], 8)
combinationSum([2,5,2,1,2], 5)



func subsets(_ nums: [Int]) -> [[Int]] {
    var set = [[Int]]()
    var current = [Int]()
    powerSet(nums, 0, &set, &current)
    return set
}

func powerSet(_ nums: [Int], _ start: Int,
              _ set: inout [[Int]], _ current: inout [Int]) {
    set.append(current)

    for i in start..<nums.count {
        if i == start || nums[i] != nums[i-1] {
            current.append(nums[i])
            powerSet(nums, i+1, &set, &current)
            current.removeLast()
        }
    }
    
}

subsets([1,2,2])

//216. Combination Sum III

func combinationSum3(_ k: Int, _ target: Int) -> [[Int]] {
    var all = [[Int]]()
    var current = [Int]()
    combsum([1,2,3,4,5,6,7,8,9], target, k, &all, &current, 0)
    return all
}

func combsum(_ arr: [Int], _ target: Int, _ k: Int,
             _ all: inout [[Int]], _ current: inout [Int], _ start: Int) {
    if target < 0 || current.count > k {
        return
    }else if target == 0 && current.count == k {
        all.append(current)
    }
    
    for i in start..<arr.count {
        current.append(arr[i])
        combsum(arr, target-arr[i], k, &all, &current, i+1)
        current.removeLast()
    }
}

combinationSum3(3, 7)

//377. Combination Sum IV

func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
    var all = [[Int]]()
    var current = [Int]()
    combsum4(nums.sorted(), target, &all, &current, 0)
//    print(all)
    var totalPer = 0
    for var item in all {
        var count = 0
        permutation(&item, 0, item.count-1, &count)
        totalPer += count
    }
    return totalPer + all.count
}

func combsum4(_ arr: [Int], _ target: Int, _ all: inout [[Int]],
              _ current: inout [Int], _ start: Int) {
    if target < 0 {
        return
    }else if target == 0 {
        all.append(current)
    }
    
    for i in start..<arr.count {
        current.append(arr[i])
        combsum4(arr, target-arr[i], &all, &current, i)
        current.removeLast()
    }
}

func permutation(_ num: inout [Int], _ l: Int, _ r: Int, _ count: inout Int) {
   
    if l == r {
        count += 1
    }else {
        for i in l...r {
//            if num[i] != num[l] {
                num.swapAt(l, i)
                permutation(&num, l+1, r, &count)
                num.swapAt(l, i)
//            }
        }
    }
}
var shit = [1,2,3]
var shitc = 0
permutation(&shit, 0, shit.count-1, &shitc)

//combinationSum4([1,2,3], 4)
//combinationSum4([4,2,1], 32)
//combinationSum4([1,2], 10)
//combinationSum4([3,1,2,4], 4)


func combsum4(_ arr: [Int], _ target: Int) -> Int {
    if target == 0 {
        return 1
    }
    var fre = 0
    for item in arr {
        if item <= target {
            fre += combsum4(arr, target-item)
        }
    }
    return fre
}

combsum4([1,2], 10)

//322. Coin Change

func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    if amount == 0 {
        return 0
    }
    var fn = [Int](repeating: 0, count: amount+1)
    for tar in 1...amount {
        var prev = Int.max-1
        for coin in coins.sorted() {
            if coin > tar {
                break
            }
            prev = min(prev, fn[tar-coin]+1)
        }
        fn[tar] = prev
    }
    return fn[amount] == (Int.max-1) ? -1 : fn[amount]
}

coinChange([1,2,5], 11)
coinChange([2], 3)
coinChange([1], 0)

//518. Coin Change 2

func coinChange2(_ coins: [Int], _ amount: Int) -> Int {
    if amount == 0 {
        return 0
    }
    var fn = [Int](repeating: 0, count: amount+1)
    fn[0] = 1
    for coin in coins.sorted() {
        for tar in coin...amount {
            fn[tar] += fn[tar-coin]
        }
    }
    print(fn)
    return fn[amount]
}

coinChange2([1, 2, 5], 5)
