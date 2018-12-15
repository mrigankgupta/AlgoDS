import DataStructSet
/*Given an array of integers, find the first missing positive integer in linear time and constant space. In other words, find the lowest positive integer that does not exist in the array. The array can contain duplicates and negative numbers as well.

 For example, the input [3, 4, -1, 1] should give 2. The input [1, 2, 0] should give 3.

 You can modify the input array in-place.*/

func findLowestPositive(arr: [Int]) -> Int {
    var min = 1
    for item in arr {
        if item <= 0 {

        } else if item <= min {
            min = min + 1
        }
    }
    return min
}

findLowestPositive(arr: [3, 4, -1, 1])
findLowestPositive(arr: [1, 2, 0])

//P27
func matchBracket(left: Character, right: Character) -> Bool {
    if left == "(" && right == ")" {
        return true
    }else if left == "[" && right == "]" {
        return true
    }else if left == "{" && right == "}" {
        return true
    }
    return false
}

func wellFormed(seq: String) -> Bool {
    var items = [Character](seq)
    var stack = Stack<Character>()
    if items.count % 2 == 1 {
        return false
    }
    stack.push(items[0])
    var indx = 1
    var match = 0
    while indx < items.count  {
        if let top = stack.top(), matchBracket(left: top, right: items[indx]) {
            stack.pop()
            match = match + 1
        }else{
            stack.push(items[indx])
        }
        indx = indx + 1
    }
    print(match)
    return match == items.count/2 ? true : false
}
wellFormed(seq: "([])[]({}){(})")
wellFormed(seq: "([])[]({}){}")

//P3

func serialize<T>(root: Node<T>?) {
    if root == nil {
        return
    }
    var current = root!
    var queue = Queue<Node<T>>()
    queue.add(current)
    while queue.count() > 0 {
        current = queue.remove()!
        print(current.data)
        if let left = current.left {
            queue.add(left)
        }
        if let right = current.right {
            queue.add(right)
        }
    }
}
var binaryTree = BinaryTree()
var sr: Node<Int>?
for elem in 1...10 {
    sr = binaryTree.levelOrderInsert(root: sr, data: elem)
}
serialize(root: sr)

/*#65
Given a N by M matrix of numbers, print out the matrix in a clockwise spiral.

For example, given the following matrix:

[[1,  2,  3,  4,  5],
[6,  7,  8,  9,  10],
[11, 12, 13, 14, 15],
[16, 17, 18, 19, 20]]
 output
 1
 2
 3
 4
 5
 10
 15
 20
 19
 18
 17
 16
 11
 6
 7
 8
 9
 14
 13
 12*/

func spiralTraversal(mat:inout [[Int]], row: Int, col:Int) {
    let total = row*col
    var index = 0
    var r = 0
    var c = 0
    while index < total {
        while c < col && mat[r][c] > 0 {
            print(mat[r][c])
            mat[r][c] = -mat[r][c]
            index+=1
            c+=1
        }
        r+=1
        c-=1
        while r < row && mat[r][c] > 0 {
            print(mat[r][c])
            mat[r][c] = -mat[r][c]
            index+=1
            r+=1
        }
        c-=1
        r-=1
        while c >= 0 && mat[r][c] > 0 {
            print(mat[r][c])
            mat[r][c] = -mat[r][c]
            index+=1
            c-=1
        }
        r-=1
        c+=1
        while r >= 0 && mat[r][c] > 0 {
            print(mat[r][c])
            mat[r][c] = -mat[r][c]
            index+=1
            r-=1
        }
        c+=1
        r+=1
    }
}

var mat = [[1,  2,  3,  4,  5],
           [6,  7,  8,  9,  10],
           [11, 12, 13, 14, 15],
           [16, 17, 18, 19, 20]]
print("spiral")
spiralTraversal(mat: &mat, row: 4, col: 5)
var mat1 = [[1,  2,  3],
           [6,  7,  8],
           [11, 12, 13],
           [16, 17, 18]]
spiralTraversal(mat: &mat1, row: 4, col: 3)
