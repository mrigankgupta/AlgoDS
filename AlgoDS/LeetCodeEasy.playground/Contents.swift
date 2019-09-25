import DataStructSet



//717. 1-bit and 2-bit Characters

func isOneBitCharacter(_ bits: [Int]) -> Bool {
    /* rule
 if second last bit is zero case: 00
 One character
 else
 if contiguous 1 from second last character is even
 One character
 else if odd
 Two character
 */
    let total = bits.count
    if bits.count == 1 {
        return true
    }else{
        if bits[total-2] == 0 {
            return true
        }else {
            var i = total-2
            while i >= 0 {
                if bits[i] == 0 {
                    break
                }else{
                    i -= 1
                }
            }
            if (total-1 - i) % 2 == 0 {
                return true
            }
        }
    }
    return false
}
//LEETcode
//720. Longest Word in Dictionary

class TrieNode<T: Hashable> {
    var dict : [T: TrieNode<T>]
    var end: Bool

    init(end: Bool = false) {
        self.dict = [T: TrieNode<T>]()
        self.end = end
    }
}

func longestWord(_ words: [String]) -> String {
    var head: TrieNode<Character>?
    for word in words {
        head = buildTrie(root: head, word: word)
    }
    var max = ""
    dfsTrie(root: head!, maxSoFar: &max, maxCurrent: "")
    return max
}
func buildTrie(root: TrieNode<Character>?, word: String) -> TrieNode<Character> {
    var head: TrieNode<Character>? = root
    if head == nil {
        head = TrieNode<Character>(end: true)
    }
    var current = head
    var charArr = [Character](word)
    for i in 0..<charArr.count {
        let char = charArr[i]
        let end = i == charArr.count-1

        if let current = current, current.dict[char] == nil {
            current.dict[char] = TrieNode<Character>(end: end)
        }
        current = current?.dict[char]
        if end {
            current?.end = end
        }
    }
    return head!
}

func dfsTrie(root: TrieNode<Character>, maxSoFar: inout String, maxCurrent: String) {
    let sorted = root.dict.keys.sorted()
    for key in  sorted {
        print(key)
        if let next = root.dict[key], next.end == true {
            let new = maxCurrent+String(key)
            if new.count > maxSoFar.count {
                maxSoFar = new
            }
            dfsTrie(root: next, maxSoFar: &maxSoFar, maxCurrent: maxCurrent+String(key))
        }
    }
}

//longestWord(["w","wo","wor","worl", "world","r"])
longestWord(["a", "banana", "app", "appl", "ap", "apply", "apple"])
//leetcode
//257. Binary Tree Paths

func binaryTreePaths(_ root: Node<Int>?) -> [String] {

    var path = [String]()
    makePath(root, current: "", path: &path)
    return path
}

func makePath(_ root: Node<Int>?, current: String, path: inout [String]) {
    if root == nil {
        return
    }
    let next = current + (current.count == 0 ? "\(root!.data)" : "->\(root!.data)")
    if root?.left == nil && root?.right == nil {
        path.append(next)
    } else {
        makePath(root?.left, current: next, path: &path)
        makePath(root?.right, current: next, path: &path)
    }
}

var br = BinaryTree()
var roo : Node<Int>?
for el in 1..<10 {
    roo = br.levelOrderInsert(root: roo, data: el)
}
binaryTreePaths(roo)

//leetcode
//35. Search Insert Position

func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    if nums.count == 0 || target < nums[0] {
        return 0
    }else if target > nums.last! {
        return nums.count
    }
    return searchBinary(nums, target, 0, nums.count-1)
}

func searchBinary(_ nums: [Int], _ target: Int,_ lft: Int, _ rgt: Int) -> Int {
    if lft < rgt {
        let mid = lft + (rgt - lft)/2
        if nums[mid] == target {
            return mid
        }else if nums[mid] > target {
            return searchBinary(nums, target, lft, mid)
        } else {
            return searchBinary(nums, target, mid+1, rgt)
        }
    }
    return lft
}

let bn = [1,3,5,7]
searchInsert(bn, 7)

//leetcode
//107. Binary Tree Level Order Traversal II


//func levelOrderBottom(_ root: Node<Int>?) -> [[Int]] {
//
//    if root == nil {
//        return [[]]
//    }
//
//    var queue = Queue<Node<Int>>()
//    queue.add(root!)
//    var stack = Stack<Node<Int>>()
//
//    while queue.count() > 0 {
//        var current = queue.remove()!
//        stack.push(current)
//        if let left = current.left {
//            queue.add(left)
//        }
//
//    }
//
//}

func levelOrderBottom(_ root: Node<Int>?) -> [[Int]] {

    var levels = [[Int]]()
    levelOrderRec(root, level: 1, levels: &levels)

    return levels.reversed()
}

func levelOrderRec(_ root: Node<Int>?, level: Int,
                   levels: inout [[Int]]) {
    if root == nil {
        return
    }
    if levels.count < level {
        levels.append([root!.data])
    }else {
        var copy = levels[level-1]
        copy.append(root!.data)
        levels[level-1] = copy
    }

    levelOrderRec(root?.left, level: level+1, levels: &levels)
    levelOrderRec(root?.right, level: level+1, levels: &levels)

}

levelOrderBottom(roo)

//Leetcode 110. Balanced Binary Tree

func isBalanced(_ root: Node<Int>?) -> Bool {

    var balanced = true
    height(root, balanced: &balanced)
    return balanced
}

func height(_ root: Node<Int>?, balanced: inout Bool) -> Int {
    if root == nil {
        return 0
    }
    let leftHeight = height(root?.left, balanced: &balanced)
    let rightHeight = height(root?.right, balanced: &balanced)
    if abs(leftHeight - rightHeight) > 1 {
        balanced = false
    }
    return max(leftHeight, rightHeight) + 1
}

isBalanced(roo)

//Leetcode 226. Invert Binary Tree


func invertTree(_ root: Node<Int>?) -> Node<Int>? {
    makeInvert(root)
    return root
}
func makeInvert(_ root: Node<Int>?) {
    if root == nil {
        return
    }
    let left = root?.left
    root?.left = root?.right
    root?.right = left
    makeInvert(root?.right)
    makeInvert(root?.left)
}

invertTree(roo)

br.levelOrderTraversal(root: roo)


func dfsInvert(root: Node<Int>?) -> Node<Int>? {
    if root == nil {
        return nil
    }

    var stack = Stack<Node<Int>>()
    stack.push(root!)
    while stack.count() > 0 {
        let current = stack.pop()
        let left = current?.left
        current?.left = current?.right
        current?.right = left

        if let left = current?.left {
            stack.push(left)
        }

        if let right = current?.right {
            stack.push(right)
        }

    }
    return root
}
dfsInvert(root: roo)
br.levelOrderTraversal(root: roo)

func bfsInvert(root: Node<Int>?) -> Node<Int>? {
    if root == nil {
        return nil
    }

    var queue = Queue<Node<Int>>()
    queue.add(root!)
    while queue.count() > 0 {
        let current = queue.remove()
        let left = current?.left
        current?.left = current?.right
        current?.right = left

        if let left = current?.left {
            queue.add(left)
        }

        if let right = current?.right {
            queue.add(right)
        }

    }
    return root
}

bfsInvert(root: roo)
br.levelOrderTraversal(root: roo)

//Leetcode
//543. Diameter of Binary Tree

func diameterOfBinaryTree(_ root: Node<Int>?) -> Int {
    var max = 0
    height(root, &max)
    return max
}

func height(_ root: Node<Int>?, _ maxTillNow: inout Int) -> Int {
    if root == nil {
        return 0
    }
    let left = height(root?.left, &maxTillNow)
    let right = height(root?.right, &maxTillNow)
    let height = max(left, right) + 1
    maxTillNow = max(maxTillNow, height)
    return height
}


//Leetcode 724



func pivotIndex(_ nums: [Int]) -> Int {

    let sum = nums.reduce(0) { r,e in return r + e }

    var leftSideSum = 0
    for i in 0..<nums.count {
        leftSideSum += nums[i]
        let rightSideSum = sum + nums[i] - leftSideSum
        if leftSideSum == rightSideSum {
            return i
        }
    }
    return -1
}


//703. Kth Largest Element in a Stream

class KthLargest {

    var nums: [Int]
    let k: Int

    init(_ k: Int, _ nums: [Int]) {
        self.k = k
        self.nums = nums.sorted(by: > )
        precondition(nums.count >= k)
    }

    func add(_ val: Int) -> Int {
        if val > nums[0] {
            nums.insert(val, at: 0)
        }else if val < nums[nums.count-1] {
            nums.append(val)
        }else {
            let index = binarySearch(nums, val, 0, nums.count-1)
            nums.insert(val, at: index)
        }
        print(nums)
        return nums[k-1]
    }

    func binarySearch(_ nums: [Int], _ find: Int, _ lft: Int, _ rgt: Int) -> Int {
        if lft < rgt {
            let mid = lft + (rgt - lft)/2
            if nums[mid] == find {
                return mid
            }else if nums[mid] < find {
                return binarySearch(nums, find, lft, mid)
            }else {
                return binarySearch(nums, find, mid+1, rgt)
            }
        }
        return lft
    }
}

let obj = KthLargest(3, [4,5,8,2])
for i in [3,5,10,9,4] {
    print(obj.add(i))
}


//709. To Lower Case


func toLowerCase(_ str: String) -> String {
    var new = ""
    for ch in str {
        if ch.isASCII && (ch.asciiValue! >= UInt8(ascii:"A")
            && ch.asciiValue! <= UInt8(ascii: "Z")) {
            let lower = UInt8(ascii:"a") + (ch.asciiValue! - UInt8(ascii:"A"))
            //            let c = Character(UnicodeScalar(lower))
            let s = String(UnicodeScalar(lower))
            new.append(s)
        }else{
            new.append(ch)
        }
    }
    return new
}

toLowerCase("Hello")


//728. Self Dividing Numbers

func selfDividingNumbers(_ left: Int, _ right: Int) -> [Int] {
    var dividing = [Int]()
    for num in left...right {
        var count: Int = num
        dividing.append(num)
        while count > 0 {
            let remainder: Int = count % 10
            count = count/10
            if remainder == 0 || num % remainder != 0 {
                dividing.removeLast()
                break
            }
        }
    }
    return dividing
}

selfDividingNumbers(1, 22)


func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ newColor: Int) -> [[Int]] {

    var copy = image
    let oldColor = image[sr][sc]
    recFlood(&copy, sr, sc, newColor, oldColor)
    return copy
}


func recFlood(_ mat: inout [[Int]], _ row: Int, _ col: Int, _ newColor: Int,_ oldColor: Int) {
    let nr = mat.count
    let nc = mat.count > 0 ? mat[0].count : 0
    mat[row][col] = newColor
    if row > 0 && mat[row-1][col] != newColor && mat[row-1][col] == oldColor {
        recFlood(&mat, row-1, col, newColor, oldColor)
    }
    if row < nr-1 && mat[row+1][col] != newColor && mat[row+1][col] == oldColor {
        recFlood(&mat, row+1, col, newColor, oldColor)
    }
    if col > 0 && mat[row][col-1] != newColor && mat[row][col-1] == oldColor {
        recFlood(&mat, row, col-1, newColor, oldColor)
    }
    if col < nc-1 && mat[row][col+1] != newColor && mat[row][col+1] == oldColor {
        recFlood(&mat, row, col+1, newColor, oldColor)
    }
}

var image = [[1,1,1],[1,1,0],[1,0,1]]
floodFill(image, 1, 1, 2)
print(image)

//463. Island Perimeter

/* Precondition

 Grid cells are connected horizontally/vertically (not diagonally). The grid is completely surrounded by water, and there is exactly one island (i.e., one or more connected land cells).

 The island doesn't have "lakes" (water inside that isn't connected to the water around the island). */

func islandPerimeter(_ grid: [[Int]]) -> Int {
    var copy = grid
    let nr = grid.count
    let nc = grid.count > 0 ? grid[0].count : 0
    for r in 0..<nr {
        for c in 0..<nc {
            if grid[r][c] == 1 {
                return recCountArea(&copy, r, c, nr, nc, 2, 1)
            }
        }
    }
    return 0
}

func recCountArea(_ mat: inout [[Int]], _ row: Int, _ col: Int,
                  _ nr: Int, _ nc: Int, _ newColor: Int,
                  _ oldColor: Int) -> Int {

    mat[row][col] = newColor
    var up = 0
    if row > 0 {
        if mat[row-1][col] == newColor {
            up -= 1
        }else if mat[row-1][col] == oldColor {
            up = recCountArea(&mat, row-1, col, nr, nc, newColor, oldColor) - 1
        }
    }
    var down = 0
    if row < nr-1 {
        if mat[row+1][col] == newColor {
            down -= 1
        }else if mat[row+1][col] == oldColor {
            down = recCountArea(&mat, row+1, col, nr, nc, newColor, oldColor) - 1
        }
    }
    var left = 0
    if col > 0 {
        if mat[row][col-1] == newColor {
            left = left - 1
        }else if mat[row][col-1] == oldColor {
            left = recCountArea(&mat, row, col-1, nr, nc, newColor, oldColor) - 1
        }
    }
    var right = 0
    if col < nc-1 {
        if mat[row][col+1] == newColor {
            right -= 1
        }else if mat[row][col+1] == oldColor {
            right = recCountArea(&mat, row, col+1, nr, nc, newColor, oldColor) - 1
        }
    }
    return 4 + left + right + up + down
}

islandPerimeter([[0,1,0,0],
                 [1,1,1,0],
                 [0,1,0,0],
                 [1,1,0,0]])
islandPerimeter([[1,1],
                 [1,1]])


//leetcode 746. Min Cost Climbing Stairs


func minCostClimbingStairs(cost: [Int]) -> Int {

    return min(minCost(cost: cost, start: -1), minCost(cost: cost, start: -2))
}

func minCost(cost: [Int], start: Int) -> Int {

    var index = start
    var minCost = 0
    while index <= cost.count-1 {
        minCost = minCost + min(cost[index+1], cost[index+2])
        index = index + (cost[index+1] < cost[index+2] ? 1 : 2)
    }
    return minCost
}

//minCostClimbingStairs(cost: [2,3,7,2,20,3,1,30])
//
//minCostClimbingStairs(cost: [1, 100, 1, 1, 1, 100, 1, 1, 100, 1])
//minCostClimbingStairs(cost: [10, 15, 20])
//minCostClimbingStairs(cost: [0,1,2,2])
//
//minCost(cost: [0,1,2,2], start: -1)
//minCost(cost: [0,1,2,2], start: 0)

func recMinCost(_ cost: [Int], _ index: Int) -> Int {
    if index <= 1 {
        return 0
    }

    return cost[index] + min(recMinCost(cost, index - 1), recMinCost(cost, index - 2))
}
recMinCost([2,3,7,2,20,3,1,30], 7)

recMinCost([1, 100, 1, 1, 1, 100, 1, 1, 100, 1], 9)
recMinCost([10, 15, 20], 2)
recMinCost([0,1,2,2], 3)

//leetcode
//309. Best Time to Buy and Sell Stock with Cooldown
func maxProfitCoolDown(_ prices: [Int]) -> Int {
    return 0
}

//Leetcode 860. Lemonade Change

func lemonadeChange(_ bills: [Int]) -> Bool {

    let currency = [20,10,5]
    var dict = [Int: Int]()


    for bill in bills {
        let given = bill - 5
        //add the coming
        dict[bill] = (dict[bill] ?? 0) + 1
        var change = given
        var index = 0
        while change > 0 && index <= currency.count-1 {
            let note = currency[index]
            let number: Int = change/note
            if let current = dict[note], current >= number {
                dict[note] = current - number
                change = change - number*note
            }
            index += 1
        }
        if change > 0 {
            return false
        }
    }
    return true
}

lemonadeChange([5,5,5,10,20])
lemonadeChange([5,5,10])
lemonadeChange([10,10])


//1029. Two City Scheduling
//REDO:
func twoCitySchedCost(_ costs: [[Int]]) -> Int {

    let row = costs.count
    let col = costs[0].count
    var index = 0
    var minCost = 0

    var sorted = costs.sorted { abs($0[0] - $0[1]) > abs($1[0] - $1[1]) }
    //    print(sorted)
    for i in 0..<row {
        /*
         count how many goes from city A or B, lets say the moment first n of A goes
         in min, rest of all from B goes to min then.
         */
        if index > row/2-1 || i-index > row/2-1 {
            if index > row/2-1 {
                minCost = minCost + sorted[i][0]
            }else {
                minCost = minCost + sorted[i][1]
            }

        }else {
            if sorted[i][0] > sorted[i][1] {
                minCost = minCost + sorted[i][1]
                index += 1
            }else {
                minCost = minCost + sorted[i][0]
            }
        }
    }

    return minCost

}

func twoCitySchedCostSimple(_ costs: [[Int]]) -> Int {

    let row = costs.count
    var minCost = 0

    var sorted = costs.sorted { $0[0] - $0[1] > $1[0] - $1[1] }// arrange according to maximum difference
    print(sorted)
    // first n would be taken from A to minimise and then taken rest n from B
    for i in 0..<row/2 {
        minCost = minCost + sorted[i][1] + sorted[row/2+i][0]
    }
    return minCost
}

twoCitySchedCost([[10,20],[30,200],[400,50],[30,20]])
twoCitySchedCost([[518,518],[71,971],[121,862],[967,607],[138,754],[513,337],[499,873],[337,387],[647,917],[76,417]])
twoCitySchedCostSimple([[10,20],[30,200],[400,50],[30,20]])
twoCitySchedCostSimple([[518,518],[71,971],[121,862],[967,607],[138,754],[513,337],[499,873],[337,387],[647,917],[76,417]])



//Leetcode 455. Assign Cookies


func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {

    //iterate greed array till end
    // see if it satisfies size if not increase size till size counter
    let greed = g.sorted()
    let size = s.sorted()
    var c = 0
    var s = 0
    while c < greed.count && s < size.count {
        if greed[c] <= size[s] {
            c += 1
        }
        s += 1
    }
    return c
}

findContentChildren([1,3,7,9,20,30], [3,3,3,9,10,25])
findContentChildren([10,9,8,7], [5,6,7,8])


//Leetcode 1005. Maximize Sum Of Array After K Negations

func largestSumAfterKNegations(_ A: [Int], _ K: Int) -> Int {

    var sum = A.reduce(0, +)
    var sorted = A

    for _ in 0..<K {
        sorted.sort()
        sorted[0] = -sorted[0]
        sum = sum + 2*sorted[0]
    }
    return sum
}

func binaryInsert(arr: [Int], lft: Int, rgt: Int, elem: Int) -> Int {

    if lft < rgt {
        let mid = lft + (rgt - lft)/2
        if arr[mid] == elem {
            return mid-1
        }else if arr[mid] > elem {
            return binaryInsert(arr: arr, lft: lft, rgt: mid, elem: elem)
        }else {
            return binaryInsert(arr: arr, lft: mid+1, rgt: rgt, elem: elem)
        }
    }else {
        return lft-1
    }

}
//wrong
func largestSumAfterKNegationsEfficient(_ A: [Int], _ K: Int) -> Int {

    var sum = A.reduce(0, +)
    var sorted = A.sorted()
    for _ in 0..<K {
        sorted[0] = -sorted[0]
        sum = sum + 2*sorted[0]
        let saved = sorted[0]
        let place = binaryInsert(arr: sorted, lft: 1, rgt: sorted.count-1, elem: sorted[0])
        //        print(place)
        if place >= 1 {
            for i in 1..<place {
                sorted[i-1] = sorted[i]
            }
        }

        sorted[place] = saved
        print(sorted)
    }
    return sum
}
largestSumAfterKNegations([2,-3,-1,5,-4], 3)

largestSumAfterKNegationsEfficient([2,-3,-1,5,-4], 3)

largestSumAfterKNegationsEfficient([4,2,3], 2)

largestSumAfterKNegationsEfficient([-8,3,-5,-3,-5,-2], 6)

//leetcode 55. Jump Game


func canJump(_ nums: [Int]) -> Bool {
    var hit = false
    jump(0, nums, &hit)
    return hit
}

func jump(_ index: Int, _ nums: [Int], _ hit: inout Bool) {
    if index >= nums.count-1 {
        hit = true
        return
    }
    for i in index+1..<(index+nums[index]+1) {
        jump(i, nums, &hit)
    }
}

canJump([2,3,1,1,4])

canJump([3,2,1,0,4])

//Leetcode 62. Unique Paths

func pathUnique(_ row: Int, _ col: Int) -> Int {
    
    if row <= 1 || col <= 1 {
        return 1
    }
    
    return pathUnique(row-1, col) + pathUnique(row, col-1)
}

pathUnique(3, 2)
pathUnique(7, 3)

func pathUniqueMemo(_ row: Int, _ col: Int) -> Int {
    
    var p = [[Int]](repeating: [Int](repeating: 0, count: col), count: row)
    
    p[0][0] = 0
    for r in 0..<row {
        for c in 0..<col {
            if r == 0 || c == 0 {
                p[r][c] = 1
            }else {
                p[r][c] = p[r-1][c] + p[r][c-1]
            }
        }
    }
    
    return p[row-1][col-1]
}

pathUniqueMemo(3,2)
pathUniqueMemo(7,3)
//Leetcode 63. Unique Paths II

func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
    let row = obstacleGrid.count
    let col = obstacleGrid[0].count
    var p = [[Int]](repeating: [Int](repeating: 0, count: col), count: row)
    
    p[0][0] = 0
    
    for r in 0..<row {
        for c in 0..<col {
            if r == 0 || c == 0 {
                if obstacleGrid[r][c] == 1 || (r == 0 && c > 0 && p[r][c-1] == 0) ||
                    (c == 0 && r > 0 && p[r-1][c] == 0) {
                    p[r][c] = 0
                } else {
                    p[r][c] = 1
                }
            } else if obstacleGrid[r][c] == 1 {
                p[r][c] = 0
            } else {
                p[r][c] = p[r-1][c] + p[r][c-1]
            }
        }
    }
    
    return p[row-1][col-1]
}

uniquePathsWithObstacles([[0,0,0],
                          [0,1,0],
                          [0,0,0]])
uniquePathsWithObstacles([[1,0]])
