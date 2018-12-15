import DataStructSet

/* 3Sum
 http://blog.gainlo.co/index.php/2016/07/19/3sum/?utm_source=forum&utm_medium=comment&utm_campaign=forum
 Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero
 */

func threeSum(_ nums: [Int]) -> [[Int]] {
    let sorted = nums.sorted()
    var result = [[Int]]()
    for (index, item) in sorted.enumerated() {
        var new = sorted
        new.remove(at: index)
        var pair = twoSum(target: -item, arr: new)
        if pair.count > 0 {
            pair.append(item)
            result.append(pair)
        }
    }
    return result
}

func twoSum(target: Int, arr: [Int]) -> [Int] {
    var lft = 0
    var rgt = arr.count-1
    var sum = 0
    while lft < rgt {
        sum = arr[lft] + arr[rgt]
        if sum < target {
            lft += 1
        }else if sum > target {
            rgt -= 1
        }else {
            let result = [Int](arrayLiteral: arr[lft], arr[rgt])
            return result
        }
    }
    return []
}

twoSum(target: 0, arr: [-4, -1, -1, 0, 1, 2])
threeSum([-1, 0, 1, 2, -1, -4])

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {

    var dict = [Int:Int]()
    for (index, elem) in nums.enumerated() {
        let other = target - elem
        print(other)
        if let lastIndex = dict[other] {
            return [lastIndex, index]
        }else {
            dict[elem] = index
        }
    }
    return []
}

twoSum([28,12,3,4,5,-19,2,7], 9)
//leetCode
//26. Remove Duplicates from Sorted Array

func removeDuplicateInSorted(arr: inout [Int]) -> Int {
    var left = 0
    var right = 0
    while right < arr.count {
        if arr[left] == arr[right] {
            right += 1
        }else {
            left = left+1
            arr.swapAt(left, right)
            right = right + 1
        }
    }
    return left
}
var sortedArr = [1,1,2]
removeDuplicateInSorted(arr: &sortedArr)
print(sortedArr)
//leetcode
//22. Generate Parentheses

func brackets(num: Int) -> [[Int]] {
    let initial = [[0],[1]]
    if num == 1 {
        return initial
    }
    let combs = brackets(num: num - 1)
    var new = [[Int]]()
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


brackets(num: 2)

//leetcode
//27. Remove Element

func removeAllInstance(arr: inout [Int], element: Int) -> Int {

    var left = 0
    for (index, item) in arr.enumerated() {
        if item == element {
            left = index
            break
        }
    }
    var right = left
    while right < arr.count {
        if arr[right] == element {
            right += 1
        }else {
            arr.swapAt(left, right)
            left += 1
            right += 1
        }
    }
    return left
}
var rai = [0,1,2,2,3,0,4,2]
removeAllInstance(arr: &rai, element: 2)
print(rai)

//leetcode
//783. Minimum Distance Between BST Nodes

func minDistanceBST(root: Node<Int>?) -> Int {

    if root == nil {
        return 0
    }
    var minDis = root!.data
    var queue = Queue<Node<Int>>()
    queue.add(root!)
    while queue.count() > 0 {
        let next = queue.remove()

        if let left = next?.left {
            queue.add(left)
            let current = next!.data - left.data
            if current < minDis {
                minDis = current
            }
        }

        if let right = next?.right {
            queue.add(right)
            let current = right.data - next!.data
            if current < minDis {
                minDis = current
            }
        }
    }
    return minDis
}

var mdbst = BinarySearchTree()
var root : Node<Int>?
for idx in [1,4,3,5,2,9,6,8] {
    root = mdbst.insert(root: root, value: idx)
}
minDistanceBST(root: root)
//Find The Longest Substring With K Unique Characters

func longestSubstringWith(unique: Int, string: String) -> String {
    var chArr = Array(string)
    var maxTillNow = 0
    var rangeTillNow: ClosedRange = 0...0
    for (start, _) in chArr.enumerated() {
        var dict = [Character : Int]()
        for index in start..<chArr.count {
            let char = chArr[index]
            if let exist = dict[char] {
                dict[char] = exist + 1
            }else{
                dict[char] = 1
            }
            if dict.keys.count == unique {
                var total = 0
                for key in dict.keys {
                    total = total + dict[key]!
                }
                if total > maxTillNow {
                    maxTillNow = total
                    rangeTillNow = start...index
                }
            }else if dict.keys.count > unique {
                break
            }
        }
        dict.removeAll()
    }
    return String(chArr[rangeTillNow])
}

longestSubstringWith(unique: 3, string: "aaabbcccddaabccddd")

//optimised
func longestSubstringOptimisedWith(unique: Int, string: String) -> String {
    var chArr = Array(string)
    var maxTillNow = 0
    var rangeTillNow: ClosedRange = 0...0
    var left = 0
    var right = 0
    var dict = [Character : Int]()
    for (start, item) in chArr.enumerated() {
        right = start
        if let exist = dict[item] {
            dict[item] = exist + 1
        }else{
            dict[item] = 1
        }
        if dict.keys.count == unique {
            var total = 0
            for key in dict.keys {
                total = total + dict[key]!
            }
            if total > maxTillNow {
                maxTillNow = total
                rangeTillNow = left...right
            }
        }else if dict.keys.count > unique {
            let itemToSlide = dict[chArr[left]]!
            dict.removeValue(forKey: chArr[left])
            left = left + itemToSlide
        }
    }
    return String(chArr[rangeTillNow])
}
longestSubstringOptimisedWith(unique: 3, string: "aaabbcccddaabccddd")

//If a String Contains an Anagram of Another String
func containsAnagram(sample: String, anagram: String) -> Bool {
    if anagram.count > sample.count {
        return false
    }
    var dict = [Character : Int]()
    for item in anagram {
        if let exist = dict[item] {
            dict[item] = exist + 1
        }else {
            dict[item] = 1
        }
    }
    var sampleCh = Array(sample)

    var left = 0
    var right = left + anagram.count-1
    var copy = dict

    while right < sample.count {
        print(left,right)
        for i in left...right {
            if let exist = copy[sampleCh[i]] {
                copy[sampleCh[i]] = exist - 1
                if exist - 1 == 0 {
                    copy.removeValue(forKey: sampleCh[i])
                }
                if copy.keys.count == 0 {
                    return true
                }
            }else{
                left = left + 1
                right = left + anagram.count-1
                copy = dict
                break
            }
        }
    }
    return false
}

containsAnagram(sample: "aaabbcccddabaccddd", anagram: "abc")


// Longest Substring Without Repeating Characters
func longestSubstringWithoutRepeating(sample: String) -> String {
    var sampleCh = Array(sample)
    var dict = [Character : Int]()
    var left = 0
    var right = 0
    var maxTillNow = 0
    var range = 0...0
    while right < sampleCh.count {
        let item = sampleCh[right]
        if let _ = dict[item] {
            dict.removeAll()
            let now = (right - left)
            if maxTillNow < now {
                maxTillNow = now
                range = left...right-1
            }
            dict[item] = 1
            left = right
        }else{
            dict[item] = 1
        }
        right += 1
    }
    let now = (right - left)
    if maxTillNow < now {
        maxTillNow = now
        range = left...right-1
    }
    return String(sampleCh[range])
}

longestSubstringWithoutRepeating(sample: "abccdefgh")
longestSubstringWithoutRepeating(sample: "abcc")
longestSubstringWithoutRepeating(sample: "aaacc")
longestSubstringWithoutRepeating(sample: "aaaa")

//Print All Paths Of a Binary Tree

func allPathBinary(root: Node<Int>?, allPath: inout [[Int]], current: inout [Int]) {
    if root == nil {
        if current.count > 0 {
            allPath.append(current)
        }
        current.removeAll()
        return
    }
    var copy = current
    copy.append(root!.data)
    allPathBinary(root: root?.left, allPath: &allPath, current: &copy)
    allPathBinary(root: root?.right, allPath: &allPath, current: &copy)
}

var apRoot: Node<Int>?
var allPathBTree = BinaryTree()
for i in 1...10 {
    apRoot = allPathBTree.levelOrderInsert(root: apRoot, data: i)
}

var allPath = [[Int]]()
var current = [Int]()
allPathBinary(root: apRoot, allPath: &allPath, current: &current)
print(allPath)

/* group anagram together
 http://blog.gainlo.co/index.php/2016/05/06/group-anagrams/
 */
func groupAnnagram(arr:[String]) -> [[String]] {

    var dict = [String:[String]]()
    for elm in arr {
        let char = [Character](elm)
        let sorted = String(char.sorted())
        if dict[sorted] == nil {
            var temparr = [String]()
            temparr.append(elm)
            dict[sorted] = temparr
        }else {
            var prev = dict[sorted]!
            prev.append(elm)
            dict[sorted] = prev
        }
    }
    var group = [[String]]()
    for (_,elem) in dict {
        group.append(elem)
    }
    return group
}

groupAnnagram(arr: ["cat", "dog", "act", "door", "odor"])

/* Given an array of non-negative numbers, find continuous subarray with sum to S.
 http://blog.gainlo.co/index.php/2016/06/01/subarray-with-given-sum/
 */
func subArraySum(arr: [Int], target: Int) -> [[Int]] {
    var left = 0
    var right = 1
    var sum = arr[left]
    var final = [[Int]]()
    while left < right {
        if sum < target && right < arr.count {
            sum += arr[right]
            right += 1
        }else if sum > target && left < arr.count {
            sum -= arr[left]
            left += 1
        } else if sum == target {
            let sub = arr[left..<right]
            final.append(Array(sub))
            sum -= arr[left]
            left += 1
        }else {
            break
        }
        //        print(left,right)
    }
    return final
}
subArraySum(arr: [1,4,6,2,5,7,8], target: 14)
subArraySum(arr: [1,4,6,2,5,7,8,2], target: 10)


//return all combination subset arrays with a given sum
//Given an array of numbers, find subarray with sum to S
//print all combination with target sum
//recursion
func allCombinationSum(arr: [Int], target: Int) -> [[Int]] {
    var final: [[Int]] = []
    var current = [Int]()
    allCombination(result: &final, arr: arr, index:0, target: target, current: &current)
    return final
}

func allCombination(result: inout [[Int]], arr:[Int], index: Int, target: Int, current: inout [Int]) -> Bool {
    if target != 0 && index == arr.count-1 {
        return false
    }

    if target == 0 {
        result.append(current)
        current.removeAll()
        return true
    }

    if arr[index] > target {
        return allCombination(result: &result, arr: arr, index: index+1, target: target, current: &current)
    }
    let notIncluded = allCombination(result: &result, arr: arr, index: index+1, target: target, current: &current)

    var copy = current
    copy.append(arr[index])
    let included = allCombination(result: &result, arr: arr, index: index+1, target: target-arr[index], current: &copy)

    return notIncluded || included
}

allCombinationSum(arr: [1,4,6,2,5,7,8], target: 14)
allCombinationSum(arr: [1,4,6,2,5,7,8], target: 10)


func longestCommonPrefix(_ strs: [String]) -> String {
    if strs.count <= 0 {
        return ""
    }
    var tag = 0
    for (idx, ch) in strs[0].enumerated() {
        for str in strs {
            if str.count > idx && str[str.index(str.startIndex, offsetBy: idx)] == ch {
                tag = idx
                print(tag)
            }else {
                let first = strs[0]
                let end = first.index(first.startIndex, offsetBy: tag)
                return String(first[first.startIndex..<end])
            }
        }

    }
    return strs[0]
}

longestCommonPrefix(["flower","flow","flight"])

//divide conquer
func longestCommonPrefixDC(_ strs: [String]) -> String {
    if strs.count == 0 {
        return ""
    }
    return divide(strs, 0, strs.count-1)
}

func divide(_ strs:[String], _ lft: Int, _ rgt: Int) -> String {
    if lft == rgt {
        return strs[lft]
    }else {
        let mid = (lft+rgt)/2
        let left = divide(strs, lft, mid)
        let right = divide(strs, mid+1, rgt)
        return lcp(left, right)
    }
}

func lcp(_ str1: String, _ str2: String) -> String {
    let carr1 = Array(str1)
    var carr2 = Array(str2)
    var short = carr1.count > carr2.count ? carr2 : carr1

    for (index, c1) in short.enumerated() {
        if carr2[index] != c1 {
            return String(short[0..<index])
        }
    }
    return String(short)
}
longestCommonPrefixDC(["flower", "flow", "float", "flvourite"])

func maximumSubArray(arr: [Int]) -> Int {
    if arr.count == 0 {
        return 0
    }
    var sofar = arr[0]
    var tillnow = arr[0]

    for index in 1..<arr.count {
        tillnow = max(arr[index], tillnow+arr[index])
        sofar = max(tillnow, sofar)
    }
    return sofar
}

maximumSubArray(arr: [-2,1,-3,4,-1,2,1,-5,4])


func lengthOfLastWord(_ s: String) -> Int {
    let arr = Array(s)
    var count = 0
    for (index, ch) in arr.reversed().enumerated() {
        count += 1
        if ch == " " {
            return index
        }
    }
    return count
}
lengthOfLastWord("hello world ")


func mergeTwoLists(_ l1: SNode<Int>?, _ l2: SNode<Int>?) -> SNode<Int>? {
    if l1 == nil {
        return l2
    }else if l2 == nil {
        return l1
    }
    var cn1 = l1
    var cn2 = l2
    var head: SNode<Int>?
    var current : SNode<Int>?
    if l1!.data < l2!.data {
        head = l1
        current = l1
        cn1 = cn1?.next
    }else {
        head = l2
        current = l2
        cn2 = cn2?.next
    }
    while cn1 != nil && cn2 != nil {
        if cn1!.data >= cn2!.data {
            current?.next = cn2
            current = current?.next
            cn2 = cn2?.next
        }else{
            current?.next = cn1
            current = current?.next
            cn1 = cn1?.next
        }
    }

    if cn1 != nil {
        current?.next = cn1
    }else if cn2 != nil {
        current?.next = cn2
    }
    return head
}
/*
 If you were only permitted to complete at most one transaction (i.e., buy one and sell one share of the stock), design an algorithm to find the maximum profit.

 Note that you cannot sell a stock before you buy one.*/

func maxProfit1(_ prices: [Int]) -> Int {
    var maxProfit = 0
    if prices.count <= 0 {
        return 0
    }
    var minVal = prices[0]
    for index in 1..<prices.count {
        maxProfit = max(maxProfit,prices[index]-minVal)
        minVal = min(prices[index],minVal)
    }
    return maxProfit
}

func maxProfit2(_ prices: [Int]) -> Int {
    var max = 0
    for i in 1..<prices.count {
        if prices[i] > prices[i-1] {
            max += prices[i] - prices[i-1]
        }
    }
    return max
}
maxProfit2([5,10,4,15,13,17,9,10,5])
// next Palindrome
func nextPalindrome(_ num: Int) -> Int {
    let numStr = String(num)
    let chStr = Array(numStr)
    let mid = chStr.count/2
    if chStr.count < 2 {
        return 11
    }
    let middle = chStr.count%2 == 1 ? String(chStr[mid+1]) : ""

    let left = numStr[numStr.startIndex...numStr.index(numStr.startIndex, offsetBy: mid-1)]
    let right = numStr[numStr.index(numStr.endIndex, offsetBy: -mid)..<numStr.endIndex]

    let reverse = Int(String(left.reversed()))!
    let rHalf = Int(String(right))!
    if reverse > rHalf {
        let final = String(left).appending(middle).appending(String(left.reversed()))
        return Int(final)!
    }else{
        var leftHalf = Int(String(left)+middle)!
        leftHalf = leftHalf + 1
        let leftString = String(leftHalf)
        if reverse == rHalf {
            //handle case for all nine
            if (num+1) % 10 == 0 {
                return num + 2
            }else {
                let final = leftString.appending(String(leftString.reversed()))
                return Int(final)!
            }
        }else{
            let final = leftString.appending(middle).appending(String(leftString.reversed()))
            return Int(final)!
        }
    }
}


nextPalindrome(1221)
nextPalindrome(999)
nextPalindrome(1111)
nextPalindrome(12349880)
nextPalindrome(9)
nextPalindrome(5)
nextPalindrome(92349880)
/*
 https://articles.leetcode.com/longest-palindromic-substring-part-i/
 Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

 Example 1:

 Input: "babad"
 Output: "bab"
 Note: "aba" is also a valid answer.
 Example 2:

 Input: "cbbd"
 Output: "bb"*/
func longestPalindrome(_ s: String) -> String {
    var cArr = [Character](s)
    var max = [Character]()

    for i in 0..<cArr.count {
        for j in (0..<cArr.count) {
            if i <= j {
                let current = Array(cArr[i...j])
                //                print(current)
                if isPalindrome(current) {
                    if current.count > max.count {
                        max = current
                    }
                }
            }

        }

    }
    return String(max)
}

func isPalindrome(_ cArr: [Character]) -> Bool {
    let count = cArr.count
    for index in 0..<count/2 {
        if cArr[index] != cArr[count-1-index]{
            return false
        }
    }
    return true
}
// complexity n*n*n
longestPalindrome("badadabcbabc")

func longestPalindromeEfficient(string: String) -> String {
    let chrs = [Character](string)
    var current = 0
    var max = 1
    var maxPalin = String(chrs[0])
    while current < chrs.count-1 {
        let palin1 = palindromeArroundCenter(char: chrs, lft: current, rgt: current)
        if let palin = palin1, palin.count > max {
            max = palin.count
            maxPalin = palin
        }
        let palin2 = palindromeArroundCenter(char: chrs, lft: current, rgt: current+1)
        if let palin = palin2, palin.count > max {
            max = palin.count
            maxPalin = palin
        }
        current += 1
    }
    return maxPalin
}

func palindromeArroundCenter(char: [Character], lft: Int, rgt: Int) -> String? {
    var l = lft
    var r = rgt
    if char[l] != char[r] {
        return nil
    }
    while l >= 0 && r <= char.count-1 && char[l] == char[r] {
        l -= 1
        r += 1
    }
    return String(char[l+1...r-1])
}
longestPalindromeEfficient(string: "dbadadabcbabc")

func convert(_ s: String, _ numRows: Int) -> String {
    if numRows < 2 {
        return s
    }
    let arr = [Character](s)
    var rows = [[Character]](repeating: [Character](), count: numRows)
    var add = 1
    var tag = 0
    for ch in arr {
        if tag == numRows-1 {
            add = -1
        }else if tag == 0 {
            add = 1
        }
        rows[tag].append(ch)
        tag += add
    }
    return String(rows.flatMap { $0 })
}

convert("PAYPALISHIRING", 3)
convert("PA", 1)

// reverse the integer
func reverse(_ x: Int) -> Int {
    var current = x
    var stack = Stack1()
    while current > 0 {
        let elem = current%10
        stack.push(elem)
        current = Int(current/10)
    }
    var sum = 0
    var mult = 1
    while stack.count() > 0 {
        mult = Int(pow(10.0,Double(stack.count()-1)))
        sum = sum + stack.pop()*mult
    }
    return sum
}

struct Stack1 {
    var arr = [Int]()
    mutating func push(_ item: Int) {
        arr.append(item)
    }
    func top() -> Int? {
        return arr.count > 0 ? arr[0] : nil
    }
    mutating func pop() -> Int {
        return arr.remove(at: 0)
    }
    func count() -> Int {
        return arr.count
    }
}
reverse(123)


/*
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.

 Example:

 Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 0 -> 8
 Explanation: 342 + 465 = 807.
 */
func addTwoNumbers(_ l1: SNode<Int>?, _ l2: SNode<Int>?) -> SNode<Int>? {
    if l1 == nil {
        return l2
    }else if l2 == nil {
        return l1
    }
    var cl1 = l1
    var cl2 = l2
    var pl1: SNode<Int>?
    var pl2: SNode<Int>?

    var carry = 0
    while cl1 != nil && cl2 != nil {
        let sum = cl1!.data + cl2!.data + carry
        cl1!.data = sum%10
        carry = Int(sum/10)
        pl1 = cl1
        pl2 = cl2
        cl1 = cl1?.next
        cl2 = cl2?.next
    }

    if cl1 == nil && cl2 == nil && carry > 0 {
        pl1?.next = SNode(data: carry)
    }else if cl1 == nil && cl2 != nil {
        pl1?.next = cl2
        while carry > 0 && cl2 != nil {
            let sum = cl2!.data + carry
            cl2!.data = sum%10
            carry = Int(sum/10)
            pl2 = cl2
            cl2 = cl2?.next
        }
        if carry > 0 {
            pl2?.next = SNode(data: carry)
        }
    }else if cl1 != nil && cl2 == nil {
        while carry > 0 && cl1 != nil {
            let sum = cl1!.data + carry
            cl1!.data = sum%10
            carry = Int(sum/10)
            pl1 = cl1
            cl1 = cl1?.next
        }
        if carry > 0 {
            pl1?.next = SNode(data: carry)
        }
    }
    return l1
}
/*
 Given a string, find the length of the longest substring without repeating characters.

 Example 1:

 Input: "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", which the length is 3.
 Example 2:

 Input: "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.
 Example 3:

 Input: "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
 Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */

func lengthOfLongestSubstring(_ s: String) -> Int {
    let charArr = [Character](s)
    var dict = [Character:Int]()
    var max = 0
    for (index, char) in charArr.enumerated() {
        if dict[char] == nil {
            dict[char] = index
        }else {
            if dict.count > max {
                max = dict.count
            }
            let last = dict[char]!
            for (key, value) in dict {
                if value < last {
                    dict[key] = nil
                }
            }
            dict[char] = index
        }
    }
    return max > dict.count ? max : dict.count
}
