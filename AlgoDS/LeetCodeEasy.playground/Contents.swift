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
