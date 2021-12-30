import DataStructSet

//658. Find K Closest Elements
//TODO:
func findClosestElements(_ arr: [Int], _ k: Int, target: Int) -> [Int] {
    if let first = arr.first, target <= first {
        let subarr = [Int](arr[0..<k])
        return subarr
    }
    
    if let last = arr.last, target >= last {
        return [Int](arr[arr.count-k..<arr.count])
    }
    
    // binary search to get index of item
    var result = [Int]()
    
    let index = binarySearch(arr, target, 0, arr.count)
    var i = index
    var j = index
    var count = 1
    while count < k && i > 0 && j < arr.count-1 {
        if abs(target - arr[i-1]) <= abs(arr[j+1] - target) {
            i -= 1
            count += 1
        }else if abs(target - arr[i-1]) > abs(arr[j+1] - target) {
            j += 1
            count += 1
        }
    }
    if count < k {
        if i == 0 {
            j = j + k - count
        }else if j == arr.count-1 {
            i = i - (k - count)
        }
    }
//    print(i,j,count)
    result = [Int](arr[i...j])
    return result
}

func binarySearch(_ arr: [Int], _ target: Int, _ start: Int, _ end: Int) -> Int {
    let mid = (end + start)/2
    if start <= end {
        if arr[mid] == target {
            return mid
        } else if arr[mid] < target {
            return binarySearch(arr, target, mid+1, end)
        } else {
            return binarySearch(arr, target, start, mid-1)
        }
    }
    return abs(target-arr[start]) > abs(target-arr[end]) ? end : start
}
//binarySearch([2,4,5,7,9,10], 5, 0, 5)
findClosestElements([2,4,5,7,9,10], 3, target: 5)
findClosestElements([1,2,3,4,5], 4, target: 3)
findClosestElements([1,1,1,10,10,10], 1, target: 9)
findClosestElements([0,1,1,1,2,3,6,7,8,9], 9, target: 4)
findClosestElements([0,0,1,2,3,3,4,7,7,8], 3, target: 5)


//1333. Filter Restaurants by Vegan-Friendly, Price and Distance
//TODO:
func filterRestaurants(_ restaurants: [[Int]], _ veganFriendly: Int, _ maxPrice: Int, _ maxDistance: Int) -> [Int] {
    let rest = restaurants.filter { $0[3] <= maxPrice && $0[4] <= maxDistance && (veganFriendly == 0 || veganFriendly == $0[2]) }.sorted (by:
    {
        if $0[1] == $1[1] {
            return $0[0] > $1[0]
        }else if $0[1] > $1[1] {
            return true
        }
        return false
    }).map { $0[0] }
    return rest
}
filterRestaurants([[1,4,1,40,10],[2,8,0,50,5],[3,8,1,30,4],[4,10,0,10,3],[5,1,1,15,1]], 1, 50, 10)
filterRestaurants([[1,4,1,40,10],[2,8,0,50,5],[3,8,1,30,4],[4,10,0,10,3],[5,1,1,15,1]],0,50,10)

//692. Top K Frequent Words

func topKFrequent(_ words: [String], _ k: Int) -> [String] {
    var dict = [String: Int]()
    
    for item in words {
        if let freq = dict[item] {
            dict[item] = freq + 1
        } else {
            dict[item] = 1
        }
    }
    
    let all = dict.sorted{
        if $0.1 > $1.1 {
            return true
        }else if $0.1 == $1.1 {
            return $0.0 < $1.0 // tricky as to compare full string, smaller comes first
        }
        return false
    }.map { $0.0 }
    return [String](all[0..<k])
}

topKFrequent(["i", "love", "leetcode", "i", "love", "coding"],2)
topKFrequent(["a","aa","aaa"],2)

///767. Reorganize String
//REDO:
/*
 1. Sort letter with their freq
 2. Put letter with max frequencies on even slot
 3. fill rest positions with remaining
 */
func reorganizeString(_ sample: String) -> String {
    var dict = [Character: Int]()
    for char in sample {
        if let val = dict[char] {
            dict[char] = val+1
        }else{
            dict[char] = 1
        }
    }
    
    let sortedKeys = dict.sorted { $0.1 > $1.1 }.map{ $0.0 }
    if let max = dict[sortedKeys[0]], max > (sample.count+1)/2 {
        return ""
    }
    var rearranged = [Character](repeating: "%", count: sample.count)
    var index = 0
    for i in stride(from: 0, to: sample.count, by: 2) {
        if let items = dict[sortedKeys[index]], items > 0 {
            rearranged[i] = sortedKeys[index]
            if items-1 == 0 {
                dict[sortedKeys[index]] = nil
                index += 1
            }else {
                dict[sortedKeys[index]] = items-1
            }
        }
    }
    for i in stride(from: 1, to: sample.count, by: 2) {
        if let items = dict[sortedKeys[index]], items > 0 {
            rearranged[i] = sortedKeys[index]
            if items-1 == 0 {
                dict[sortedKeys[index]] = nil
                index += 1
            }else {
                dict[sortedKeys[index]] = items-1
            }
        }
    }
    return String(rearranged)
}

reorganizeString("aab")
reorganizeString("aaba")
reorganizeString("aaabbbccdd")
reorganizeString("baaba")
reorganizeString("vvvlo")


//994. Rotting Oranges
//REDO:
//func orangesRotting(_ grid: [[Int]]) -> Int {
//    var mGrid = grid
//    var counter = 0
//    for i in 0..<grid.count {
//    for j in 0..<grid[0].count {
//            if grid[i][j] == 2 {
//                counter = max(counter, rotting(&mGrid, 0, i, j))
//            }
//        }
//    }
//    return counter
//}
//
//func rotting(_ grid: inout [[Int]], _ counter: Int, _ r: Int, _ c: Int) -> Int {
//
//    grid[r][c] = 2
//    var up = 0
//    if r > 0 && grid[r-1][c] == 1 {
//        up = rotting(&grid, counter+1, r-1, c)
//    }
//    var down = 0
//    if r < grid.count-1 && grid[r+1][c] == 1 {
//        down = rotting(&grid, counter+1, r+1, c)
//    }
//    var left = 0
//    if c > 0 && grid[r][c-1] == 1 {
//        left = rotting(&grid, counter+1, r, c-1)
//    }
//    var right = 0
//    if c < grid[0].count-1 && grid[r][c+1] == 1 {
//        right = rotting(&grid, counter+1, r, c+1)
//    }
//    let leftRight = max(left, right)
//    let upDown = max(up,down)
//    return max(counter , max(leftRight, upDown))
//}

func orangesRotting(_ grid: [[Int]]) -> Int {
    var mGrid = grid
    var counter = 0
    var queue = Queue<(Int,Int, Int)>()
    for i in 0..<grid.count {
    for j in 0..<grid[0].count {
            if grid[i][j] == 2 {
                queue.append((i, j, 0))
            }else if grid[i][j] == 1 {
                counter += 1
            }
        }
    }
    var maxStep = 0
    while queue.count() > 0 {
        if let (r,c, step) = queue.remove() {
            maxStep = max(maxStep, step)
            if mGrid[r][c] == 2 {
                mGrid[r][c] = -2
                if r > 0 && mGrid[r-1][c] == 1 {
                    mGrid[r-1][c] = 2
                    queue.append((r-1,c, step+1))
                    counter -= 1
                }
                if r < mGrid.count-1 && mGrid[r+1][c] == 1 {
                    mGrid[r+1][c] = 2
                    queue.append((r+1,c,step+1))
                    counter -= 1
                }
                if c > 0 && mGrid[r][c-1] == 1 {
                    mGrid[r][c-1] = 2
                    queue.append((r,c-1,step+1))
                    counter -= 1
                }
                if c < mGrid[0].count-1 && mGrid[r][c+1] == 1 {
                    mGrid[r][c+1] = 2
                    queue.append((r,c+1,step+1))
                    counter -= 1
                }
            }
        }
    }
    return counter > 0 ? -1 : maxStep
}


var rottingm = [[2,1,1],[1,1,0],[0,1,1]]
orangesRotting(rottingm)
rottingm = [[1,1,1,2,1,1,2,1,1,1,1]]
orangesRotting(rottingm)
rottingm = [[2],[1],[1],[1],[2],[1],[1]]
orangesRotting(rottingm)

//138. Copy List with Random Pointer

class MNode: Hashable {
    public var val: Int
    public var next: MNode?
    public var random: MNode?
    public init(_ val: Int) {
        self.val = val
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(val)
    }
}

extension MNode : Equatable {
    static func ==(_ lhs: MNode, _ rhs: MNode) -> Bool {
        return lhs.val == rhs.val && lhs.next == rhs.next && lhs.random == rhs.random
    }
}

func copyRandomList(_ head: MNode?) -> MNode? {

    if head == nil {
        return nil
    }
    var new: MNode?
    var dict = [MNode : MNode]()
    copyList(head, &dict, &new)
    return new
}

func copyList(_ head: MNode?, _ dict: inout [MNode : MNode], _ new: inout MNode?) {
    if let head = head {
        if new == nil {
            new = MNode(head.val)
            dict[head] = new!
        }
        
        if let next = head.next, let nxtNode = dict[next] {
            dict[head]?.next = nxtNode
        }else if let next = head.next {
            let nxtNode = MNode(next.val)
            dict[next] = nxtNode
            dict[head]?.next = nxtNode
        }
        
        if let rand = head.random, let rndNode = dict[rand] {
            dict[head]?.random = rndNode
        }else if let rand = head.random {
            let rndNode = MNode(rand.val)
            dict[rand] = rndNode
            dict[head]?.random = rndNode
        }
        copyList(head.next, &dict, &new)
    }
}

func copyRandomList1(_ head: MNode?) -> MNode? {
    if head == nil {
        return nil
    }
    var current: MNode? = head
    let new = MNode(head!.val)
    var newCurr: MNode? = new
    var dict = [MNode : MNode]()

    while current != nil {
        let next = current?.next
        if let next = next, let exist = dict[next] {
            newCurr?.next = exist
        }else if let next = next {
            let new = MNode(next.val)
            newCurr?.next = new
            dict[next] = new
        }
        let nextRand = current?.random
        if let nextRand = nextRand, let rand = dict[nextRand] {
            newCurr?.random = rand
        }else if let nextRand = nextRand {
            let new = MNode(nextRand.val)
            newCurr?.random = new
            dict[nextRand] = new
        }
        current = current?.next
        newCurr = newCurr?.next
        
    }
    return new
}


//Minimum Number of Platforms Required for a Railway/Bus Station

func station(_ arrivl: [Int], _ depart: [Int], _ n: Int) -> Int {
    
    let arv = arrivl.sorted()
    let dep = depart.sorted()
    var i = 1
    var j = 0
    var reqStation = 1
    var maxS = 1
    
    while i < n && j < n {
        if arv[i] <= dep[j] {
            reqStation += 1
            i += 1
        }else if arv[i] > dep[j] {
            reqStation -= 1
            j += 1
        }
        
        maxS = max(reqStation, maxS)
    }
    return maxS
}

station([900, 940, 950, 1100, 1500, 1800], [910, 1200, 1120, 1130, 1900, 2000], 6)
