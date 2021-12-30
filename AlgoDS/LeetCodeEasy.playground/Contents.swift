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
//    queue.append(root!)
//    var stack = Stack<Node<Int>>()
//
//    while queue.count() > 0 {
//        var current = queue.remove()!
//        stack.push(current)
//        if let left = current.left {
//            queue.append(left)
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
    queue.append(root!)
    while queue.count() > 0 {
        let current = queue.remove()
        let left = current?.left
        current?.left = current?.right
        current?.right = left

        if let left = current?.left {
            queue.append(left)
        }

        if let right = current?.right {
            queue.append(right)
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

//637. Average of Levels in Binary Tree
class LevelNode<T> {
    var data: T?
    var left: LevelNode<T>?
    var right: LevelNode<T>?
    var level: Int = 0
}
func averageOfLevels(_ root: LevelNode<Int>?) -> [Double] {
    if root == nil {
        return [0]
    }

    var queue = Queue<LevelNode<Int>>()
    queue.append(root!)

    while queue.count() > 0 {
        let next = queue.remove()!
        let currentLevel = next.level

        if let left = next.left {
            left.level = currentLevel + 1
            queue.append(left)
        }

        if let right = next.right {
            right.level = currentLevel + 1
            queue.append(right)
        }

    }
    return [0]
}

func averageOfLevels(_ root: Node<Int>?) -> [Double] {
    var arr = [[Int]]()
    traversal(root, 0, &arr)
    var avgArr = [Double]()
    for row in arr {
        var sum = 0
        for item in row {
            sum = sum + item
        }
        let avg = Double(sum)/Double(row.count)
        avgArr.append(avg)
    }
    return avgArr
}

func traversal(_ root: Node<Int>?, _ level: Int, _ arr: inout [[Int]]) {
    if root == nil {
        return
    }
    if arr.count-1 < level {
        arr.append([root!.data])
    }else {
        var current = arr.remove(at: level)
        current.append(root!.data)
        arr.insert(current, at: level)
    }
    traversal(root?.left, level+1, &arr)
    traversal(root?.right, level+1, &arr)
}

var average: Node<Int>?
let averageTree = BinaryTree()
average = averageTree.buildTree(0, [1,2,3,nil,4,nil,5,nil,nil,6,7])
averageTree.levelOrderTraversal(root: average)
averageOfLevels(average)

//125. Valid Palindrome

func isPalindrome(_ s: String) -> Bool {
    if s.count <= 0 {
        return false
    }
    let char = [Character](s)
    var i = 0
    var j = s.count-1
    let smallA = Int(("a" as Character).asciiValue!)//TODO: RemindMe
    let smallZ = Int(("z" as Character).asciiValue!)
    
    let capitalA = Int(("A" as Character).asciiValue!)
    let capitalZ = Int(("Z" as Character).asciiValue!)
    
    let diff = abs(capitalA - smallA)
    while i <= j {
        if !(char[i].isASCII && (smallA <= char[i].asciiValue!
            && char[i].asciiValue! <= smallZ || capitalA <= char[i].asciiValue!
            && char[i].asciiValue! <= capitalZ)) {
            i += 1
        }else if !(char[j].isASCII && (smallA <= char[j].asciiValue!
            && char[j].asciiValue! <= smallZ || capitalA <= char[j].asciiValue!
            && char[j].asciiValue! <= capitalZ)) {
            j -= 1
        }else {
            let current = abs(Int(char[i].asciiValue!) - Int(char[j].asciiValue!))
            if char[i] == char[j] || current == diff {
                i += 1
                j -= 1
            }else {
                return false
            }
        }
    }
    return true
}

isPalindrome("A man, a plan, a canal: Panama")
isPalindrome("race a car")
isPalindrome("0w")
isPalindrome("0")
isPalindrome("w0ww")


//414. Third Maximum Number
//REDO:
func thirdMax(_ nums: [Int]) -> Int {
    
    var maxthree: Set<Int> = Set()
    for item in nums {

        if maxthree.count < 3 {
            maxthree.insert(item)
        }else {
            let minInThree = maxthree.min()!
            // remove only if not previously in Set
            if item > minInThree && maxthree.insert(item).inserted {
                maxthree.remove(minInThree)
            }
        }
    }
    return maxthree.count >= 3 ? maxthree.min()! : maxthree.max()!
}

thirdMax([3, 2, 1])
thirdMax([1,2])
thirdMax([1,2,3,4,2])
thirdMax([22,15,22,17,5,15,20,27])
thirdMax([1,2,2,5,3,5])


//350. Intersection of Two Arrays II

func intersectionOfTwoUnsorted(_ arr1: inout [Int], _ arr2: inout [Int]) -> [Int] {
    
    arr1.sort()
    arr2.sort()
    var i = 0
    var j = 0
    var result = [Int]()
    while i < arr1.count && j < arr2.count {
        if arr1[i] == arr2[j] {
            result.append(arr1[i])
            i += 1
            j += 1
        }else if arr1[i] < arr2[j] {
            i += 1
        }else {
            j += 1
        }
    }
    return result
}
var a1 = [9,2,6,1,9,3]
var a2 = [9,9,1,3]
intersectionOfTwoUnsorted(&a1, &a2)

func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    
    var dict = [Int: Int]()
    var smler = nums2
    var bigr = nums1
    if nums1.count < nums2.count {
        smler = nums1
        bigr = nums2
    }
    for item in smler {
        if let freq = dict[item] {
            dict[item] = freq + 1
        }else {
            dict[item] = 1
        }
    }
    var result = [Int]()
    for item in bigr {
        if let freq = dict[item] {
            result.append(item)
            let new = freq - 1
            if new > 0 {
                dict[item] = new
            }else {
                dict.removeValue(forKey: item)
            }
        }
    }
    return result
}

//278. First Bad Version

class Version {
    
    private var dict = [Int: Bool]()
    
    init(_ badVersion: Int, _ total: Int) {
        for item in 1...total {
            dict[item] = item >= badVersion ? false : true
        }
    }
    
    public func isBadVersion(_ num: Int) -> Bool {
        return dict[num]!
    }
    
    func badVersion(_ lft: Int, _ rght: Int) -> Int {
        let mid = lft + (rght-lft)/2
        if lft < rght {
            if isBadVersion(mid) == false {
                return badVersion(lft, mid)
            } else {
                return badVersion(mid+1, rght)
            }
        }
        return lft
    }
}

var version = Version(6, 10)
version.badVersion(1, 10)


//344. Reverse String

func reverseString(_ s: inout [Character]) {
    var i = 0
    var j = s.count - 1
    
    while i < j {
        s.swapAt(i, j)
        i += 1
        j -= 1
    }
}
var srev: [Character] = ["h","e","l","l","o"]
reverseString(&srev)

//766. Toeplitz Matrix

func isToeplitzMatrix(_ matrix: [[Int]]) -> Bool {
    let row = matrix.count
    let col = matrix[0].count
    
    for i in 0..<col {
        var c = i
        var r = 0
        while r < row-1 && c < col-1 {
            if matrix[r][c] != matrix[r+1][c+1] {
                return false
            }else{
                print(matrix[r][c], matrix[r+1][c+1])
                r += 1
                c += 1
            }
        }
    }
    if row < 1 {
        return false
    }
    for i in 1..<row {
        var c = 0
        var r = i
        while r < row-1 && c < col-1 {
            if matrix[r][c] != matrix[r+1][c+1] {
                return false
            }else{
                print(matrix[r][c], matrix[r+1][c+1])
                r += 1
                c += 1
            }
        }
    }
    
    return true
}

isToeplitzMatrix([[1,2,3,4],[5,1,2,3],[9,5,1,2]])
isToeplitzMatrix([[1]])

//1213. Intersection of Three Sorted Arrays
//REDO: what if 4 array are there
//efficient but not 100% correct
//func mergeThreeWithCommon(_ arr1: [Int], _ arr2: [Int], _ arr3: [Int]) -> [Int] {
//
//    var i = 0
//    var j = 0
//    var k = 0
//    var result = [Int]()
//    while i < arr1.count && j < arr2.count && k < arr3.count {
//
//        if arr1[i] == arr2[j] && arr2[j] == arr3[k] {
//            result.append(arr1[i])
//           i += 1
//           j += 1
//           k += 1
//        } else {
//            if arr1[i] == arr2[j] {
//                if arr1[i] < arr3[k] {
//                    i += 1
//                    j += 1
//                }else {
//                    k += 1
//                }
//                continue
//            }else if arr1[i] < arr2[j] {
//                i += 1
//            }else {
//                j += 1
//            }
//            if arr2[j] == arr3[k] {
//                if arr1[i] > arr3[k] {
//                    k += 1
//                    j += 1
//                }else {
//                    i += 1
//                }
//                continue
//            }else if arr2[j] < arr3[k] {
//                j += 1
//            }else {
//                k += 1
//            }
//        }
//    }
//    return result
//}

func mergeThreeWithCommon(_ arr1: [Int], _ arr2: [Int], _ arr3: [Int]) -> [Int] {

    var i = 0
    var j = 0
    var k = 0
    var result = [Int]()
    while i < arr1.count && j < arr2.count && k < arr3.count {
        if arr1[i] == arr2[j] && arr2[j] == arr3[k] {
            result.append(arr1[i])
           i += 1
           j += 1
           k += 1
        } else if arr1[i] < arr2[j] {
            i += 1
        } else if arr2[j] < arr3[k] {
            j += 1
        } else {
            k += 1
        }
    }
    return result
}
mergeThreeWithCommon([1,2,3,4,5],[1,2,5,7,9],[1,3,4,5,8])
mergeThreeWithCommon( [1, 4, 7],[2, 5, 8],[3, 6, 9])

//977. Squares of a Sorted Array

func sortedSquares(_ arr: [Int]) -> [Int] {
    
    var i = 0
    var j = arr.count-1
    var k = j
    var result = [Int](repeating: 0, count: arr.count)
    while i <= j {
        let left = arr[i]*arr[i]
        let right = arr[j]*arr[j]
        if left < right {
            result[k] = right
            j -= 1
        }else {
            result[k] = left
            i += 1
        }
        k -= 1
    }
    return result
}
var sample = [-4,-1,0,3,10]
var sample1 = [-4,-3,-2,1]
sortedSquares(sample)
sortedSquares(sample1)

//339. Nested List Weight Sum

func depthSum(_ nestedList: String) -> Int {
    var cm = 0
    var sum = 0
    for ch in nestedList {
        if ch == "[" {
            cm += 1
        }else if ch == "]" {
            cm -= 1
        }else if ch.isWholeNumber {//TODO: Remind me
            sum += ch.wholeNumberValue!*cm
        }
    }
    return sum
}

depthSum("[[1,1],2,[1,1]]")

//938. Range Sum of BST

func rangeSumBST(_ root: Node<Int>?, _ L: Int, _ R: Int) -> Int {
    var sum = 0
//    dfsSum(root, L, R, sum: &sum)
    dfsSumIterator(root, L, R, sum: &sum)
    return sum
}

func dfsSum(_ root: Node<Int>?, _ L: Int, _ R: Int, sum: inout Int) {
    guard let nroot = root else {
        return
    }
    
    if nroot.data >= L && nroot.data <= R {
        sum = sum + nroot.data
        dfsSum(nroot.left, L, R, sum: &sum)
        dfsSum(nroot.right, L, R, sum: &sum)

    }else if nroot.data > R {
        dfsSum(nroot.left, L, R, sum: &sum)
    }else if nroot.data < L {
        dfsSum(nroot.right, L, R, sum: &sum)
    }
}


func dfsSumIterator(_ root: Node<Int>?, _ L: Int, _ R: Int, sum: inout Int) {
    guard let nroot = root else {
        return
    }
    
    var stack = Stack<Node<Int>>()
    stack.push(nroot)
    
    while !stack.empty() {
        let top = stack.pop()!
        if top.data >= L && top.data <= R {
            sum = sum + top.data
        }
        if let left = top.left {
            stack.push(left)
        }
        if let rgt = top.right {
            stack.push(rgt)
        }
    }
}


var bfsSum = BinarySearchTree()

var root938: Node<Int>?
for i in [10,5,15,3,7] {
    root938 = bfsSum.insert(root: root938, value: i)
}
bfsSum.inorderTraversal(root: root938)
rangeSumBST(root938, 7, 15)

///448. Find All Numbers Disappeared in an Array
//[4,3,2,7,8,2,3,1]
func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
    var arr = nums
    for (_, item) in arr.enumerated() {
        if arr[item-1] > 0 {
            arr[item-1] = -arr[item-1]
        }
    }
    var list = [Int]()
    for (idx, item) in arr.enumerated() {
        if item > 0 {
            list.append(idx+1)
        }
    }
    return list
}

findDisappearedNumbers([4,3,2,7,8,2,3,1])

///442. Find All Duplicates in an Array
//O(nlogn)
func findDuplicates(_ nums: [Int]) -> [Int] {
    let sorted = nums.sorted()
    var list = [Int]()
    for idx in 0..<sorted.count-1 {
        let xor = sorted[idx]^sorted[idx+1]
        if xor == 0 {
            list.append(sorted[idx])
        }
    }
    return list
}

findDuplicates([4,3,2,7,8,2,3,1])

func findDuplicatesOptimise(_ nums: [Int]) -> [Int] {
    var arr = nums
    var list = [Int]()
    for (_, item) in arr.enumerated() {
        if arr[item-1] > 0 {
            arr[item-1] = -arr[item-1]
        } else {
            list.append(item)
        }
    }
    return list
}
findDuplicatesOptimise([4,3,2,7,8,2,3,1])

findDuplicatesOptimise([10,2,5,10,9,1,1,4,3,7])


//169. Majority elements
// Bayer moore method

/*
 majority element if that number comes more then half of times
 so if we count majority elemnts +1 by some way and other element as -1. Ultimately
 what left is majority element.
 */
//REDO:
func majorityElement(_ nums: [Int]) -> Int? {
    
    var maj: Int?
    var sum = 0
    for num in nums {
        if sum == 0 {
            maj = num
        }
        if num == maj {
            sum = sum + 1
        }else {
            sum = sum - 1
        }
    }
    var count = 0
    for num in nums {
        if maj == num {
            count += 1
        }
    }
    if count > nums.count/2 {
        return maj
    }
    return nil
}

majorityElement([1,2,3,3,3,3,2,2,3])

/*
- Orignal array modified
- Only if elements are 1 < e < n and size of array is n
 Idea is to add count to the item at index, equal to same value encountered.
 then divide it by count to get how many times its being added.
 */
func majorityElementIndexMethod(_ nums: inout [Int]) -> Int {

    let count = nums.count
    
    for num in nums {
        let val = num%count
        nums[val] = nums[val] + count
    }
    print(nums)
    var max = 0
    var maxItem = -1
    for num in nums {
        let frq = num/count
        if frq > max {
            max = frq
            maxItem = num%count
        }
    }
    print(max)
    return maxItem
}
var sh = [1,2,3,3,3,3,2,2,3,]
majorityElementIndexMethod(&sh)

// 229. Majority Element II

 func majorityElement2(_ nums: [Int]) -> [Int] {
    var count1: Int = 0
    var count2: Int = 0
    var fst: Int?
    var scd: Int?
    
    for num in nums {
        
       if fst == num {
            count1 += 1
        }else if scd == num {
            count2 += 1
       }else if fst == nil {
            fst = num
            count1 += 1
        }else if scd == nil {
            scd = num
            count2 += 1
        }else if fst != num && scd != num {
            count1 -= 1
            count2 -= 1
        if count1 == 0 {
            fst = nil
        }
        if count2 == 0 {
            scd = nil
        }
        
        }
    }
    count2 = 0
    count1 = 0
    var list = [Int]()
    for num in nums {
        if fst == num {
            count1 += 1
        }
        if scd == num {
            count2 += 1
        }
    }
//    print(count2, count1, fst, scd)
    if count1 > nums.count/3, let fst = fst {
        list.append(fst)
    }
    if count2 > nums.count/3, let scd = scd {
        list.append(scd)
    }
    return list
 }

majorityElement2([0,3,4,0])
majorityElement2([2,2,1,3])

majorityElement2([1,1,1,2,3,4,5,6])
majorityElement2([4,2,1,1])
majorityElement2([-1,1,1,1,2,1])
//TODO:
//953. Verifying an Alien Dictionary
func isAlienSorted(_ words: [String], _ order: String) -> Bool {
    
    // compare two unless char are equal, if a[i] > b[i] ? false : true
    // make dictionary
    if words.count <= 1 {
        return true
    }
    var dict = [Character: Int]()
    for (index, char) in order.enumerated() {
        dict[char] = index
    }
    
    for idx in 0..<words.count - 1 {
        if !compare(words[idx], words[idx+1], dict) {
            return false
        }
    }
    return true
}

func compare(_ fst: String,_ sec: String, _ dict: [Character: Int]) -> Bool {

    var i = 0
    while i < fst.count {
        if i > sec.count - 1 {
            return false
        }
        let fstChar = fst[fst.index(fst.startIndex, offsetBy: i)]
        let secChar = sec[sec.index(sec.startIndex, offsetBy: i)]

        let fstVal = dict[fstChar]!
        let secVal = dict[secChar]!
        if fstVal == secVal {
            i += 1
            continue
        }else if fstVal <= secVal  {
            return true
        }
        return false
    }
    return false
}
isAlienSorted(["hello","leetcode"], "hlabcdefgijkmnopqrstuvwxyz")
isAlienSorted(["word","world","row"], "worldabcefghijkmnpqstuvxyz")
isAlienSorted(["apple","app"], "abcdefghijklmnopqrstuvwxyz")
//["fxasxpc","dfbdrifhp","nwzgs","cmwqriv","ebulyfyve","miracx","sxckdwzv","dtijzluhts","wwbmnge","qmjwymmyox"]
//"zkgwaverfimqxbnctdplsjyohu"

//346. Moving Average from Data Stream

class MovingAverage {
    private var size: Int
    private lazy var arr = [Int]()
    /** Initialize your data structure here. */
    init(_ size: Int) {
        self.size = size
    }
    
    func next(_ val: Int) -> Double {
        arr.append(val)
        let med = arr.count < size ? arr.count : size
        var sum = 0
        for i in (arr.count-med)..<arr.count {
            sum += arr[i]
        }
        return Double(sum)/Double(med)
    }
}

let mv = MovingAverage(3)
mv.next(10)
mv.next(8)
mv.next(3)
mv.next(3)
//604. Design Compressed String Iterator

class StringIterator {
    private var startIndex: String.Index?
    private var freq = 0
    private var freqWidth = 0
    private var last: Int
    private var current: Character?
    private var compressed: String

    init(_ compressedString: String) {
        self.compressed = compressedString
        last = compressed.count
    }

    func next() -> Character {
        guard startIndex != nil else {
            startIndex = compressed.startIndex
            current = compressed.first
            startIndex = compressed.index(after: startIndex!)
            (freqWidth, freq) = nextFrequencyDigit(startIndex!)
            startIndex = compressed.index(startIndex!, offsetBy: freqWidth)
            return current!
        }
        if startIndex! >= compressed.endIndex && freq == 1 {
            return "+"
        }
        if freq > 1 {
            freq -= 1
            return current!
        } else {
            current = String(compressed[startIndex!...startIndex!]).first!
            startIndex = compressed.index(after: startIndex!)
            (freqWidth, freq) = nextFrequencyDigit(startIndex!)
            startIndex = compressed.index(startIndex!, offsetBy: freqWidth)
            return current!
        }
    }

    func hasNext() -> Bool {
        return freq > 0
    }

    func isNumber(_ index: String.Index) -> Bool {
        if let freqChar = String(compressed[index...index]).first {
            if let ascii = freqChar.asciiValue, ascii >= 48, ascii < 58 {
                return true
            }
        }
        return false
    }

    func nextFrequencyDigit(_ startIndex: String.Index) -> (Int, Int) {
        var next = startIndex
        var end: String.Index = startIndex
        while next < compressed.endIndex && isNumber(next) {
            end = next
            next = compressed.index(after: next)
        }
        let freqString = String(compressed[startIndex...end])
        return (freqString.count, Int(freqString)!)
    }
}
let sam = "L11e2f3"
var iterator = StringIterator(sam)
for _ in 0..<10{
    print(iterator.next())
}

//299. Bulls and Cows
//TODO:
func getHint(_ secret: String, _ guess: String) -> String {
    
    var sdict = [Character: Int]()

    let sChars = [Character](secret)
    let gChars = [Character](guess)
    var bulls = 0
    var cows = 0
    for item in sChars {
        if let exist = sdict[item]  {
            sdict[item] = exist + 1
        }else{
            sdict[item] = 1
        }
    }
    
    for item in gChars {
        if let preexist = sdict[item] {
            if preexist - 1 == 0 {
                sdict[item] = nil
            }else {
                sdict[item] = preexist - 1
            }
            cows += 1
        }
    }
    for i in 0..<gChars.count {
        if gChars[i] == sChars[i] {
            bulls += 1
            cows -= 1
        }
    }
    return "\(bulls)A\(cows)B"
}
getHint("1807","7871")
getHint("11","10")
getHint("11","01")
getHint("1123","0111")
getHint("1807","7871")
getHint("1122","1222")

///359. Logger Rate Limiter
//TODO:
class Logger {

    var msgDict: [String : [Int]]
    /** Initialize your data structure here. */
    init() {
        self.msgDict = [String : [Int]]()
    }

    /** Returns true if the message should be printed in the given timestamp, otherwise returns false.
        If this method returns false, the message will not be printed.
        The timestamp is in seconds granularity. */
    func shouldPrintMessage(_ timestamp: Int, _ message: String) -> Bool {
        if var exist = msgDict[message] {
            if timestamp - exist.last! < 10 {
                return false
            }else {
                while let first = exist.first, timestamp - first > 10  {
                    // TODO: Do remember that dropFirst() will return
                    // new array slice but do not modify cureent array.
                    exist.removeFirst()
                }
                exist.append(timestamp)
                msgDict[message] = exist
                return true
            }
        } else {
            msgDict[message] = [timestamp]
            return true
        }
    }
}
let loger = Logger()

//let items = [(0,"A0"),(4,"A2"),(8,"A2"),(12,"A4"),(16,"A1"),(20,"A3"),(24,"A2"),(28,"A4"),(32,"A3"),(36,"A1")]
let items = [(0,"A"),(0,"B"),(0,"C"),(0,"A"),(0,"B"),(0,"C"),(11,"A"),(11,"B"),(11,"C"),(11,"A")]
for item in items {
    print(loger.shouldPrintMessage(item.0, item.1))
}

//844. Backspace String Compare
//TODO: REDO: //shit
func backspaceCompare(_ S: String, _ T: String) -> Bool {
    
    var i = S.count-1
    var j = T.count-1
    let sChar = [Character](S)
    let tChar = [Character](T)
    var hashS = 0
    var hashT = 0
    while i >= 0 || j >= 0 {
        
        if i >= 0 && sChar[i] == "#" {
            hashS += 1
            i -= 1
        }else if hashS > 0 {
            hashS -= 1
            i -= 1
        }else if j >= 0 && tChar[j] == "#" {
            hashT += 1
            j -= 1
        }else if hashT > 0 {
            hashT -= 1
            j -= 1
        }else if i >= 0 && j >= 0 && sChar[i] == tChar[j] {
            i -= 1
            j -= 1
        }else if (i >= 0 && j >= 0 && sChar[i] != tChar[j]) || i < 0 || j < 0 {
//            print(sChar[i], tChar[j])
            return false
        }
    }
    return true
}



backspaceCompare("ab#c", "ad#c")
backspaceCompare("ab##", "c#d#")
backspaceCompare("a##c", "#a#c")
backspaceCompare("a#c", "b")
backspaceCompare("bxj##tw", "bxj###tw")

//1047. Remove All Adjacent Duplicates In String

func removeDuplicates(_ S: String) -> String {
    if S.count < 1 {
        return S
    }
    let chars = [Character](S)
    var stack = Stack<Character>()
    stack.push(chars[0])
    for i in 1..<chars.count {
        if let top = stack.top(), top == chars[i] {
            stack.pop()
        }else {
            stack.push(chars[i])
        }
    }
    var new = ""
    while !stack.empty() {
        new.append(stack.pop()!)
    }
    return String(new.reversed())
}

removeDuplicates("abbaca")

//1209. Remove All Adjacent Duplicates in String II

func removeDuplicates(_ s: String, _ k: Int) -> String {
    if s.count < 1 {
        return s
    }
    let chars = [Character](s)
    var stack = Stack<Character>()
    var nstack = Stack<Int>()
    stack.push(chars[0])
    nstack.push(1)
    for i in 1..<chars.count {
        if let top = stack.top(), top == chars[i] {
            if let count = nstack.top(), count + 1 == k {
                var toPop = count
                while toPop > 0 {
                    stack.pop()
                    nstack.pop()
                    toPop -= 1
                }
            } else if let count = nstack.top() {
                stack.push(chars[i])
                nstack.push(count+1)
            }
        }else {
            stack.push(chars[i])
            nstack.push(1)
        }
    }
    var new = ""
    while !stack.empty() {
        new.append(stack.pop()!)
    }
    return String(new.reversed())
}

removeDuplicates("pbbcggttciiippooaais", 2)
removeDuplicates("deeedbbcccbdaa", 3)


//496. Next Greater Element I

func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var result = [Int]()
    for item in nums1 {
        var min = -1
        var found = false
        for index in 0..<nums2.count {
            if nums2[index] == item {
                found = true
            }else if found && nums2[index] > item {
                min = nums2[index]
                break
            }
        }
        result.append(min)
    }
    return result
}

nextGreaterElement([4,1,2], [1,3,4,2])
nextGreaterElement([2,4], [1,2,3,4])

//1342. Number of Steps to Reduce a Number to Zero

func numberOfSteps(_ num: Int) -> Int {
    var target = num
    var step = 0
    while target != 0 {
        if target % 2 == 0 {
            target /= 2
            step += 1
        }else {
            target -= 1
            step += 1
        }
    }
    return step
}

numberOfSteps(14)
numberOfSteps(8)
numberOfSteps(123)

//1281. Subtract the Product and Sum of Digits of an Integer

func subtractProductAndSum(_ n: Int) -> Int {
    var sum = 0
    var multi = 1
    var tar = n
    while tar > 0 {
        let elem = tar % 10
        tar /= 10
        sum += elem
        multi *= elem
    }
    return multi - sum
}

subtractProductAndSum(234)
subtractProductAndSum(21)

//1021. Remove Outermost Parentheses
// dont push if counter is zero
func removeOuterParentheses(_ paranths: String) -> String {
    
    var counter = 0
    var final = ""
    for pran in paranths {
        if pran == ")" {
            counter -= 1
        }
        if counter != 0 {
            final.append(pran)
        }
    
        if pran == "(" {
            counter += 1
        }
    }
    return final
}

removeOuterParentheses("()")

removeOuterParentheses("(()())(())(()(()))")

removeOuterParentheses("(()())(())")

removeOuterParentheses("()()")


func peakIndexInMountainArray(_ arr: [Int]) -> Int {
    
    for i in 1..<arr.count-1 {
        if arr[i-1] < arr[i] && arr[i] > arr[i+1] {
            return i
        }
    }
    return -1
}

func peakIndexInMountainArrayBinary(_ arr: [Int]) -> Int {
    var lo = 0
    var hi = arr.count-1
    while lo < hi {
        let mid = lo + (hi-lo)/2
        
        if arr[mid] < arr[mid+1] {
            lo = mid+1
        }else{
            hi = mid
        }
    }
    return lo
}

peakIndexInMountainArray([0,1,0])
peakIndexInMountainArray([0,2,1,0])

peakIndexInMountainArrayBinary([0,1,0])
peakIndexInMountainArrayBinary([0,2,1,0])
peakIndexInMountainArrayBinary([0,2,4,17,100,1000,1017,1040,20,11,9,7,4,3,2,1])

//1051. Height Checker

func heightChecker(_ heights: [Int]) -> Int {
    let sorted = heights.sorted()
    var diff = 0
    for i in 0..<heights.count {
        if sorted[i] != heights[i] {
            diff += 1
        }
    }
    return diff
}
heightChecker([1,1,4,2,1,3])
heightChecker([5,1,2,3,4])

//821. Shortest Distance to a Character
/*
 1. go forward and fill distance, if char is not seen fill Int.max or count+1 to distance
 2. go backward and calculate distance, take the min of forward and backward calculated distance and save in array
 */
func shortestToChar(_ sample: String, _ C: Character) -> [Int] {
    let chars = [Character](sample)
    var dist = sample.count+1
    var arr = [Int]()
    //forward
    for item in sample {
        if item == C {
            dist = 0
        }else if dist != sample.count+1 {
            dist += 1
        }
        arr.append(dist)
    }
    //backward
    dist = sample.count+1
    for i in (0..<sample.count).reversed() {
        if chars[i] == C {
            dist = 0
        }else if dist != sample.count+1 {
            dist += 1
        }
        arr[i] = min(arr[i], dist)
    }
    return arr
}

shortestToChar("loveleetcode", "e")

///349. Intersection of Two Arrays

func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    let set1 = Set(nums1)
    let set2 = Set(nums2)
    
    return [Int](set1.intersection(set2))
}

intersection([1,2,2,1], [2,2])
intersection([4,9,5], [9,4,9,8,4])

///242. Valid Anagram

func isAnagram(_ s: String, _ t: String) -> Bool {
    if s.count != t.count {
        return false
    }
    var chars = [Int](repeating: 0, count: 26)
    let a: Character = "a"
    let asciiA = a.asciiValue!
    for item in s {
        chars[Int(item.asciiValue! - asciiA)] += 1
    }
    
    for item in t {
        chars[Int(item.asciiValue! - asciiA)] -= 1
        if chars[Int(item.asciiValue! - asciiA)] < 0 {
            return false
        }
    }
    return true
}

isAnagram("anagram", "nagrama")
isAnagram("anagram", "nagramaa")
isAnagram("cat", "tac")
isAnagram("ab", "a")

///389. Find the Difference

func findTheDifference(_ s: String, _ t: String) -> Character {
    
    var dict = [Character: Int]()
    
    for item in s {
        if let count = dict[item] {
            dict[item] = count+1
        }else {
            dict[item] = 1
        }
    }
    var char: Character?
    for item in t {
        if let count = dict[item] {
            dict[item] = count-1
            if count-1 == 0 {
                dict[item] = nil
            }
        }else{
            char = item
        }
    }
    
    guard let chr = char else {
        return dict.keys.first!
    }
    return chr
}

findTheDifference("abdc", "eadcb")
findTheDifference("a", "aa")

//1056. Confusing Number

func confusingNumber(_ N: Int) -> Bool {
    if N == 0 {
        return false
    }
    var remain = N
    var next = 0
    let set = [0, 1, 6, 8, 9]
    var rev = ""
    while remain > 0 {
        next = remain % 10
        if !set.contains(next) {
            return false
        }
        remain /= 10
        if next == 6 {
            next = 9
        }else if next == 9 {
            next = 6
        }
        rev.append(String(next))
    }
    if Int(rev) == N {
        return false
    }
    return true
}

confusingNumber(68)
confusingNumber(25)
confusingNumber(1)
confusingNumber(11)
confusingNumber(18)
confusingNumber(0)

//665. Non-decreasing Array
/* Algo
 

*/
func checkPossibility(_ nums: [Int]) -> Bool {
    var count = 0
    for i in 0..<nums.count {
        if !((i == 0 || nums[i-1] < nums[i]) && (i == nums.count-1 || nums[i+1] > nums[i])) {
            if count > 3 {
                return false
            }else if i == 0 || i == nums.count-1 {
                count += 2
            }else {
                count += 1
            }
        }
    }
    return true
}

func checkPossibilityBrute(_ nums: [Int]) -> Bool {
    for i in 0..<nums.count {
        var count = 0
        for index in i..<nums.count-1 {
            if nums[index+1] < nums[i] {
                if count+1 > 1 {
                    return false
                }else {
                    count += 1
                }
            }
        }
        
    }
    return true
}

checkPossibility([3,5,6,7,9,8])
checkPossibility([1,4,2])
checkPossibility([3,5,6])
checkPossibility([3,4,2,3])
checkPossibility([4,2,1])
checkPossibility([4,2,3])

//246. Strobogrammatic Number

func isStrobogrammatic(_ num: String) -> Bool {
    if num.count == 0 {
        return false
    }
    var rev = ""
    
    for item in num.reversed() {
        var next = item
        let set: [Character] = ["0", "1", "6", "8", "9"]
        if !set.contains(item) {
            return false
        }
        if next == "6" {
            next = "9"
        }else if next == "9" {
            next = "6"
        }
        rev.append(String(next))
    }
    print(rev,num)
    if rev == num {
        return true
    }
    return false
}

isStrobogrammatic("6")
isStrobogrammatic("69")
isStrobogrammatic("969")
isStrobogrammatic("88")
isStrobogrammatic("11")
isStrobogrammatic("968018661806000118986811000908199810896")

//1394. Find Lucky Integer in an Array

func findLucky(_ arr: [Int]) -> Int {
    
    var dict = [Int: Int]()
    
    for item in arr {
        if let count = dict[item] {
            dict[item] = count + 1
        }else {
            dict[item] = 1
        }
    }
    var max = -1
    for key in dict.keys {
        if key == dict[key] && key > max {
            max = key
        }
    }
    return max
}
//REDO:
func findLuckyHigh(_ arr: [Int]) -> Int {
    //Remember
    return arr.reduce(into: [Int:Int]()) { dict,item in dict[item , default: 0] += 1 }.reduce(into: -1) { (r, arg1)  in
        if arg1.key == arg1.value && r < arg1.key {
            r = arg1.key
        }
    }
}
findLuckyHigh([2,2,3,4])
findLuckyHigh([1,2,2,3,3,3])
findLuckyHigh([2,2,2,3,3])
findLuckyHigh([7,7,7,7,7,7,7])



///581. Shortest Unsorted Continuous Subarray
//REDO:
func findUnsortedSubarray(_ nums: [Int]) -> Int {
    let count = nums.count
    var allSorted = true
    // find first down slope and then min
    var minIndex = 0
    var min = 0
    for i in 0..<count-1 {
        if nums[i] > nums[i+1] {
            minIndex = i
            min = nums[i+1]
            allSorted = false
            break
        }
    }
    if allSorted {
        return 0
    }
    
    for i in minIndex..<count {
        if nums[i] < min {
            min = nums[i]
        }
    }
    // find the correct position of min
//    print(min)
    for i in 0..<count {
        if nums[i] > min {
            minIndex = i
            break
        }
    }
    
    // find first up slope and then max from reverse
    var maxIndex = count-1
    var max = 0
    for i in (1..<count).reversed() {
        if nums[i] < nums[i-1] {
            maxIndex = i
            max = nums[i-1]
            break
        }
    }
    
    for i in (0..<maxIndex).reversed() {
        if nums[i] > max {
            max = nums[i]
        }
    }
//    print(max)
    // find the correct position of max
    for i in (0..<count).reversed() {
        if nums[i] < max {
            maxIndex = i
            break
        }
    }
    return abs(maxIndex - minIndex)+1
}

findUnsortedSubarray([2, 6, 4, 8, 10, 9, 15])
findUnsortedSubarray([2, 1])
findUnsortedSubarray([5,4,3,2,1])
findUnsortedSubarray([1,3,2,3,3])
findUnsortedSubarray([1,2,3,4])
findUnsortedSubarray([1,3,2,2,2])

/**
 https://leetcode.com/problems/shortest-unsorted-continuous-subarray/discuss/103057/Java-O(n)-Time-O(1)-Space
 iterate from the beginning, find out *last* element which is lesser then last seen max from the left side
 mark it as the end
 
 
 iterate from the end, find out *last* element which is greater then last seen min from the right side
 mark it as the beginning
 
 length = end - beginning + 1
 **/

func findUnsortedSubarrayAwesome(_ arr: [Int]) -> Int {
    let count = arr.count
    var maxSoFar = Int.min
    var end = -2
    for i in 0..<count {
        maxSoFar = max(arr[i], maxSoFar)
        if arr[i] < maxSoFar {
            end = i
        }
    }
    print(end)
    var minSoFar = Int.max
    var begin = -1

    for i in (0..<count).reversed() {
        minSoFar = min(arr[i], minSoFar)
        if arr[i] > minSoFar {
            begin = i
        }
    }
    print(begin)
    // for sorted case -2 + 1 + 1 = 0
    return end - begin + 1
}
findUnsortedSubarrayAwesome([2, 6, 4, 8, 10, 9, 15])
findUnsortedSubarrayAwesome([2, 1])
findUnsortedSubarrayAwesome([5,4,3,2,1])
findUnsortedSubarrayAwesome([1,3,2,3,3])
findUnsortedSubarrayAwesome([1,2,3,4])
findUnsortedSubarrayAwesome([1,3,2,2,2])


//298. Binary Tree Longest Consecutive Sequence

func longestConsecutive(_ root: Node<Int>?) -> Int {
    
    var maxm = 0
    sequence(root, 0, &maxm)
    return maxm > 0 ? maxm+1 : 0
}

func sequence(_ root: Node<Int>?, _ current: Int, _ maxm: inout Int) {
    if root == nil {
        return
    }
    
    if let left = root?.left, left.data - root!.data == 1 {
        maxm = max(maxm, current+1)
        sequence(left, current+1, &maxm)
    }else {
        sequence(root?.left, 0, &maxm)
    }
    if let right = root?.right, right.data - root!.data == 1 {
        maxm = max(maxm, current+1)
        sequence(right, current+1, &maxm)
    }else {
        sequence(root?.right, 0, &maxm)
    }
}
let lbt = BinaryTree()
//var lbtRoot = lbt.buildTree(0, [1,nil,3,2,4,nil,nil,nil,5])
func treeForCon() -> Node<Int> {
    let root = Node(data: 1)
    root.right = Node(data:3)
    root.right?.left = Node(data:2)
    root.right?.right = Node(data:4)
    root.right?.right?.right = Node(data:5)
    return root
}

longestConsecutive(treeForCon())

//941. Valid Mountain Array

func validMountainArray(_ arr: [Int]) -> Bool {
    if arr.count == 0 {
        return false
    }
    var increasing = 0
    for i in 1..<arr.count {
        if increasing == 0 {
            if arr[i] > arr[i-1] {
                increasing = 1
            }else{
                return false
            }
        }else if increasing == 1 && arr[i] < arr[i-1] {
            increasing = -1
        }else if increasing == -1 && arr[i] >= arr[i-1] {
            return false
        }
    }
    return increasing == -1
}

validMountainArray([2,1])
validMountainArray([3,5,5])
validMountainArray([0,3,2,1])
validMountainArray([0,1,2,1,0])
validMountainArray([2,1,2,3,5,7,9,10,12,14,15,16,18,14,13])
validMountainArray([14,82,89,84,79,70,70,68,67,66,63,60,58,54,
                   44,43,32,28,26,25,22,15,13,12,10,8,7,5,4,3])

validMountainArray([0,1,2,3,2,1,4,5,6,5,4])


