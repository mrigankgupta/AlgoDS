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
    queue.append(root!)
    while queue.count() > 0 {
        let next = queue.remove()

        if let left = next?.left {
            queue.append(left)
            let current = next!.data - left.data
            if current < minDis {
                minDis = current
            }
        }

        if let right = next?.right {
            queue.append(right)
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

func groupAnagramEfficient(_ strs: [String]) -> [[String]] {
    var arr = [[String]]()
    var dict = [Int64 : [String]]()
    for str in strs {
        let key = calHash(str)
        if let items = dict[key] {
            var new = Array(items)
            new.append(str)
            dict[key] = new
        }else {
            dict[key] = [str]
        }
    }
    for key in dict.keys {
        arr.append(dict[key]!)
    }
    return arr
}

func calHash(_ str: String) -> Int64 {
    let prime: [Int64] = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 41, 43, 47,
                          53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103]
    let chAr = [Character](str)
    var hash: Int64 = 1// can easyly get overflowed
    let aAscii: Character = "a"
    for ch in chAr {
        hash *= prime[ch.ascii() - aAscii.ascii()]
    }
    return hash
}

groupAnagramEfficient(["eat", "tea", "tan", "ate", "nat", "bat"])


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
func maxProfit(_ prices: [Int]) -> Int {
    if prices.count <= 1 {
        return 0
    }

    var minSoFar = prices[0]
    var maxSoFar = prices[0]
    var maxProfit = maxSoFar - minSoFar
    for i in 1..<prices.count {
        let newMin = min(minSoFar,prices[i])

        if minSoFar > newMin {
            minSoFar = newMin
            maxSoFar = prices[i]
        }else {
            maxSoFar = max(maxSoFar,prices[i])
        }
        let newProfit = (maxSoFar - minSoFar)
        if maxProfit < newProfit {
            maxProfit = newProfit
        }
    }
    return maxProfit
}
func maxProfitMethod2(_ prices: [Int]) -> Int {
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



//leetcode
//122. Best Time to Buy and Sell Stock II
//method 1 max profit untill next valley comes
func maxProfitII(_ prices: [Int]) -> Int {
    if prices.count <= 1 {
        return 0
    }
    var minSoFar = prices[0]
    var maxSoFar = prices[0]
    var maxProfit = 0
    for i in 1..<prices.count {
        let newMin = min(minSoFar,prices[i])
        if minSoFar > newMin {
            minSoFar = newMin
            maxSoFar = newMin
            continue
        }
        let newMax = max(prices[i],maxSoFar)
        if maxSoFar == newMax {
            minSoFar = prices[i]
            maxSoFar = prices[i]
        }else {
            maxProfit = maxProfit + (newMax-maxSoFar)
            maxSoFar = newMax
        }
    }
    return maxProfit
}

func maxProfitIIMethod2(_ prices: [Int]) -> Int {
    var max = 0
    for i in 1..<prices.count {
        if prices[i] > prices[i-1] {
            max += prices[i] - prices[i-1]
        }
    }
    return max
}
maxProfitIIMethod2([5,10,4,15,13,17,9,10,5])

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

//leetcode
//461. Hamming Distance

func hammingDistance(_ x: Int, _ y: Int) -> Int {

    var result = x^y
    let mask = 1
    var count = 0
    while result > 0 {
        if mask & result == 1 {
            count += 1
        }
        result = result >> 1
    }
    return count
}

hammingDistance(1, 4)

//88. Merge Sorted Array

func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    var i = m-n-1
    var j = n-1
    var current = m-1

    while i >= 0 && j >= 0 {
        if nums1[i] < nums2[j] {
            nums1[current] = nums2[j]
            j -= 1
            current -= 1
        }else {
            nums1.swapAt(i, current)
            current -= 1
            i -= 1
        }
    }
    while j >= 0 {
        nums1[current] = nums2[j]
        current -= 1
        j -= 1
    }
}
var num1 = [1,2,3,0,0,0]
merge(&num1, 6, [2,5,6], 3)

num1 = [2,3,4,0,0,0]
merge(&num1, 6, [1,5,6], 3)

//leetcode
//67. Add Binary

func addBinary(_ a: String, _ b: String) -> String {
    var big = [Character](a)
    var small = [Character](b)
    if big.count < small.count {
        let temp = big
        big = small
        small = temp
    }
    var b = big.count-1
    var s = small.count-1
    var result = [Character]()
    var carry = 0
    while b >= 0 || s >= 0 || carry > 0 {
        var sum = 0
        if s >= 0 && b >= 0 {
            print("shit",carry)
            sum =  integerVal(big[b]) + integerVal(small[s]) + carry
            carry = sum/2
            let item = sum%2
            print("sum",sum, item, carry)
            result.append(item > 0 ? "1" : "0")
            s -= 1
            b -= 1
        }else if b >= 0 {
            sum =  integerVal(big[b]) + carry
            carry = sum/2
            let item = sum%2 + carry
            result.append(item > 0 ? "1" : "0")
            b -= 1
        }else if carry > 0 {
            result.append(carry > 0 ? "1" : "0")
            carry = 0
        }

    }
    return String(result.reversed())
}

func integerVal(_ ch: Character) -> Int {
    return ch == "0" ? 0 : 1
}

addBinary("1100", "1101")
//leetcode
//13. Roman to Integer
//I             1
//V             5
//X             10
//L             50
//C             100
//D             500
//M             1000
func romanToInt(_ s: String) -> Int {
    var chArr = [Character](s)
    var sum = 0
    for (index, item) in chArr.enumerated() {
        if index < chArr.count-1 && valueForRom(chArr[index]) < valueForRom(chArr[index+1]) {
            sum -= valueForRom(item)
        }else {
            sum += valueForRom(item)
        }
    }
    return sum
}

func valueForRom(_ ch: Character) -> Int {
    switch ch {
    case "I":
        return 1
    case "V":
        return 5
    case "X":
        return 10
    case "L":
        return 50
    case "C":
        return 100
    case "D":
        return 500
    case "M":
        return 1000
    default:
        return 0
    }
}

romanToInt("LIVIII")
romanToInt("MCMXCIV")

//leetcode
//572. Subtree of Another Tree

func isSubtree(_ s: Node<Int>?, _ t: Node<Int>?) -> Bool {
    var match = false
    traverse(s, t, &match)
    return match
}

func traverse(_ s: Node<Int>?, _ t: Node<Int>?, _ match:inout Bool) {
    if t == nil {
        return
    }

    if s!.data == t!.data {
        match = isMatch(s, t)
        if match == true {
            return
        }
    }
    traverse(s, t?.left, &match)
    traverse(s, t?.right, &match)
}

func isMatch(_ s: Node<Int>?, _ t: Node<Int>?) -> Bool {
    if s == nil && t == nil {
        return true
    }
    if s != nil && t == nil {
        return false
    }
    if s == nil && t != nil {
        return false
    }
    if t!.data != s!.data {
        return false
    }
    let left = isMatch(s?.left, t?.left)
    let right = isMatch(s?.right, t?.right)
    return left == true && right == true
}

var bt = BinaryTree()
var t : Node<Int>?
for i in [3,4,5,1,2,6,7] {
    t = bt.levelOrderInsert(root: t, data: i)
}
var s : Node<Int>?
for i in [4,1,2] {
    s = bt.levelOrderInsert(root: s, data: i)
}
isSubtree(s, t)
//leetcode
//680. Valid Palindrome II

func validPalindrome(_ s: String) -> Bool {
    let chArr = [Character](s)
    _ = chArr.count/2
    let start = 0
    let end = chArr.count-1
    let shit = isPalindrome(chArr, start, end)
    if -1 != shit  {
        return -1 == isPalindrome(chArr, start+shit, end-shit-1) ||
            -1 == isPalindrome(chArr, start+shit+1, end-shit)
    }
    return true
}

func isPalindrome(_ chArr: [Character], _ start: Int, _ end: Int) -> Int {
    let mid = (start+end)/2
    var left = start
    var right = end

    while left <= mid && right >= mid {
        if chArr[left] == chArr[right] {
            left += 1
            right -= 1
        }else{
            print(left)
            return left
        }
    }
    return -1
}
validPalindrome("aabbaaa")
validPalindrome("abc")

//func validPalindromeClean(_ s: String) -> Bool {
//    let chArr = [Character](s)
//    let start = 0
//    let end = chArr.count-1
//    let offset = isPalindromeClean(chArr, start, end)
//    if -1 != offset {
//        return -1 == isPalindromeClean(chArr, start+offset, end-offset-1) ||
//            -1 == isPalindromeClean(chArr, start+offset+1, end-offset)
//    }
//    return true
//}
//
//func isPalindromeClean(_ chArr: [Character], _ start: Int, _ end: Int) -> Int {
//    let mid = (start+end)/2
//    for i in start...mid {
//        if chArr[i] != chArr[end-i] {
//            return i
//        }
//    }
//    return -1
//}
//validPalindromeClean("aabbaaa")
//validPalindromeClean("abc")

//isPalindromeClean([Character]("aabaaa"), 0, 5)
//isPalindromeClean([Character]("ab"), 0, 1)



//leetcode
//637. Average of Levels in Binary Tree

func calHeight(_ root: Node<Int>?, _ height: Int) -> Int {
    if root == nil {
        return height
    }
    return max(calHeight(root?.left, height), calHeight(root?.right, height)) + 1
}
var test: Node<Int>?
for i in [1,2,3,4,5,6]  {
    test = bt.levelOrderInsert(root: test, data: i)
}
calHeight(test, -1)

func levelOrderTrav(_ root: Node<Int>?) {
    let height = calHeight(root, -1)
    for i in (0...height).reversed() {
        traverseLevel(root, i)
    }
}

func traverseLevel(_ root: Node<Int>?, _ level: Int) {
    if root == nil {
        return
    }
    if level == calHeight(root, -1) {
        print(root?.data, level)
    }
    traverseLevel(root?.left, level)
    traverseLevel(root?.right, level)
}

levelOrderTrav(test)

struct LevelNode <T> {
    var level: Int
    var node: Node<T>
}
func levelOrderTravQue(_ root: Node<Int>?) -> [[Int]] {
    if root == nil {
        return [[]]
    }
    var queue = Queue<LevelNode<Int>>()
    var level = 0
    var current: LevelNode<Int>?
    var list = [[Int]]()
    queue.append(LevelNode(level: level+1, node: root!))

    while queue.count() > 0 {
        current = queue.remove()
        if current!.level != level {
            list.append([current!.node.data])
            level = current!.level
        }else{
           var last = list.removeLast()
            last.append(current!.node.data)
            list.append(last)
        }
        if let current = current {
            print("level",level,current.node.data)
            if let left = current.node.left {
                queue.append(LevelNode(level: level + 1, node: left))
            }

            if let right = current.node.right {
                queue.append(LevelNode(level: level + 1, node: right))
            }
        }
    }
    return list
}

struct MyQueue<T> {

    var arr1 = [T]()

    mutating func add(_ item: T) {
        arr1.append(item)
    }

    mutating func remove() -> T? {
        if arr1.count > 0 {
            return arr1.remove(at: 0)
        }
        return nil
    }

    func count() -> Int {
        return arr1.count
    }
}

levelOrderTravQue(test)

//404. Sum of Left Leaves

func sumOfLeftLeaves(_ root: Node<Int>?) -> Int {
    var sum = 0
    leftLeaves(root, false, &sum)
    return sum
}

func leftLeaves(_ root: Node<Int>?, _ left: Bool, _ sum: inout Int) {
    if root == nil {
        return
    }
    if left == true && root!.left == nil && root!.right == nil {
        sum += root!.data
    }

    leftLeaves(root?.left, true, &sum)
    leftLeaves(root?.right, false, &sum)
}

//653. Two Sum IV - Input is a BST
//O(n) space
func findTarget(_ root: Node<Int>?, _ k: Int) -> Bool {
    var arr = [Int]()
    inOrderFind(root, &arr)

    var left = 0
    var right = arr.count-1
    while left < right {
        let sum = arr[left] + arr[right]
        if sum > k {
            right -= 1
        }else if sum < k {
            left += 1
        }else {
            return true
        }
    }
    return false
}

func inOrderFind(_ root: Node<Int>?, _ arr: inout [Int]) {
    if root == nil {
        return
    }
    inOrderFind(root?.left, &arr)
    arr.append(root!.data)
    inOrderFind(root?.right, &arr)
}

func findTargetNoExtraSpace(_ root: Node<Int>?, _ k: Int) -> Bool {
    if root == nil {
        return false
    }
    return inOrderBinarySearch(root!, root, k)
}

func inOrderBinarySearch(_ root: Node<Int>, _ current: Node<Int>?, _ k: Int) -> Bool {
    if current == nil {
        return false
    }
    return bSearch(root, k - current!.data, current!) || inOrderBinarySearch(root, current?.left, k) || inOrderBinarySearch(root, current?.right, k)
}

func bSearch(_ root: Node<Int>?, _ diff: Int, _ current: Node<Int>) -> Bool {
    if root == nil {
        return false
    }
    if root!.data == diff && current.data != root!.data {
        return true
    }else if diff > root!.data {
        return bSearch(root?.right, diff, current)
    }else {
        return bSearch(root?.left, diff, current)
    }
}

let bst = BinarySearchTree()
var rb : Node<Int>?
for i in [5,3,6,2,4,7,9] {
    rb = bst.insert(root: rb, value: i)
}
findTargetNoExtraSpace(rb, 9)
findTargetNoExtraSpace(rb, 11)

for i in [1] {
    rb = bst.insert(root: rb, value: i)
}
findTargetNoExtraSpace(rb, 2)

for i in [2,1,3] {
    rb = bst.insert(root: rb, value: i)
}
findTargetNoExtraSpace(rb, 3)

for i in [5,3,6,2,4] {
    rb = bst.insert(root: rb, value: i)
}
findTargetNoExtraSpace(rb, 28)

//leetcode
//543. Diameter of Binary Tree

func diameterOfBinaryTree(_ root: Node<Int>?) -> Int {
    var maximum = 0
    diameter(root, &maximum)
    return maximum
}

func diameter(_ root: Node<Int>?, _ maximum: inout Int) -> Int {
    if root == nil {
        return 0
    }
    let left = diameter(root?.left, &maximum)
    let right = diameter(root?.right, &maximum)
    let current = max(left, right) + 1
    maximum = max(current, maximum)
    return current
}

diameterOfBinaryTree(rb)

//leetcode
//REDO
//4. Median of Two Sorted Arrays

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {

    var result = merge(nums1, nums2)
    let total = nums1.count + nums2.count
    let mid = (total)/2
    let median = total%2 != 1 ? Double(result[mid-1] + result[mid])/2.0 : Double(result[mid])
    return median
}

func merge(_ nums1: [Int], _ nums2: [Int]) -> [Int] {

    var left = 0
    var right = 0

    var result = [Int]()
    while left < nums1.count && right < nums2.count {
        if nums1[left] < nums2[right] {
            result.append(nums1[left])
            left += 1
        }else {
            result.append(nums2[right])
            right += 1
        }
    }


    if left < nums1.count {
        result.append(contentsOf: nums1[left...nums1.count-1])
    }else if right < nums2.count {
        result.append(contentsOf: nums2[right...nums2.count-1])
    }
    return result
}

findMedianSortedArrays([1,3], [2])
findMedianSortedArrays([1,2], [3,4])
findMedianSortedArrays([], [3,4])

//Leetcode 199. Binary Tree Right Side View

struct Level<T> {

    var node: Node<T>
    var level: Int
}

func rightSideViewComplexO_N(root: Node<Int>?) -> [Int] {
    if root == nil {
        return []
    }
    var rightSide = [Int]()
    var current: Level<Int>? = Level(node: root!, level: 0)
    var queue = Queue<Level<Int>?>()
    queue.append(current)
    var printed = 0

    while queue.count() > 0 {
        current = queue.remove()!
        let level = current!.level
        let node = current!.node
        if printed == level {
            rightSide.append(current!.node.data)
            printed += 1
        }
        if let right = node.right {
            queue.append(Level(node: right, level: level+1))
        }
        if let left = node.left {
            queue.append(Level(node: left, level: level+1))
        }

    }
    return rightSide
}

var binaryTree = BinaryTree()
var sr: Node<Int>?
for elem in 1...10 {
    sr = binaryTree.levelOrderInsert(root: sr, data: elem)
}
rightSideViewComplexO_N(root: sr)


func rightSideViewRec(_ root: Node<Int>?, _ sideR: inout [Int], level: Int) {
    if root == nil {
        return
    }
    if level == sideR.count {
        sideR.append(root!.data)
    }
    rightSideViewRec(root?.right, &sideR, level: level+1)
    rightSideViewRec(root?.left, &sideR, level: level+1)
}
var rSide = [Int]()
rightSideViewRec(sr, &rSide, level: 0)

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
            1,2                        1                         2                       [Empty]
    |-------|-------|           |-------|-------|        |-------|-------|         |-------|-------|
1,2,3             1,2          1,3              1       2,3              2         3             [Empty]

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

/*
                                                              0..<3
                                                                []
                                                                |
                        1..<3                                  2..<3                    3..<3
                        |----------------------------------------|------------------------|
                      [1][]                                    [1][]                     [][1]
           2..<3                   3..<3                       3..<3
            |------------------------|                           |
         [1,2][2]                   [1,2][2]                   [1,3][3]
            |
          3..<3
        [1,2,3][2,3]
*/
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
        subsetsMethod2(nums, i+1, &set, &current)// i+1 for avoiding infinite loop here and dup
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
        // num[i] != num[i+1] will not work as it will skip some permutaion due to for loop starting.
        // for example 1,2,2 if we take last 2 as pair then it is not making any pair with 2
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
/*
 this will build from down to Top
 so first permutation will be
 [1]
 then for two
 [1,2] [2,1]
 so first take previous combinations
 append the new item in last position
 then swap that last element with all other elements
 */
func allPermutation(_ nums: [Int]) -> [[Int]] {
    return permute(nums, nums.count-1)
}

func permute(_ nums: [Int], _ end: Int) -> [[Int]] {
    if end <= 0 {
        return [[nums[0]]]
    }
    /* calculate prev*/
    let prev = permute(nums, end-1)
    // append item
    var new: [[Int]] = prev.map {
        var fo = [Int]($0)
        fo.append(nums[end])
        return fo
    }
    // swap
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

//39. Combination Sum

/* Given a set of candidate numbers (candidates) (without duplicates) and a target number (target), find all unique combinations in candidates where the candidate numbers sums to target.
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
    // why sorted because if we don't sort we would not be able to find
    // those combination which could come from smaller numbers in the end of orignal
    // array because recursion terminate due to sum > target condition with bigger number.
    allComb(candidates.sorted(), target, 0, &comb, &current, 0)
    return comb
}

func allComb(_ candidates: [Int], _ target: Int, _ sum: Int, _ comb: inout [[Int]],
             _ current: inout [Int], _ start: Int) {

    for i in start..<candidates.count {// if we start from zero everytime we collect dup combination with different order
        let item = candidates[i]
        if sum+item == target {
            current.append(item)
            comb.append(current)
            return
        }else if sum+item < target {
            var copy = current
            copy.append(item)
            allComb(candidates, target, sum + item, &comb, &copy, i)// why i not i + 1 because we want repeat number
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


//75. Sort Colors
//most fucking shit I dont know
//REDO:
func sortColors(_ nums: inout [Int]) {
    var lastZero = -1
    var lastOne = -1
    for current in 0..<nums.count {
        if nums[current] == 0 {
            if nums[lastOne+1] == 2 {
                nums[current] = 2
            }
            if lastOne >= 0 && nums[lastOne] == 1 {
                nums[lastOne+1] = 1
            }
            nums[lastZero+1] = 0

            lastOne += 1
            lastZero += 1
        }else if nums[current] == 1 {
            if nums[lastOne+1] == 2 {
                nums[current] = 2
            }
            nums[lastOne+1] = 1

            lastOne += 1
        }
    }
}

func sortColors1(_ nums: inout [Int]) {
    var n0 = -1, n1 = -1, n2 = -1
    for i in 0..<nums.count {
        if (nums[i] == 0) {
            n2 += 1
            nums[n2] = 2
            n1 += 1
            nums[n1] = 1
            n0 += 1
            nums[n0] = 0
        }else if (nums[i] == 1) {
            n2 += 1
            n1 += 1
            nums[n2] = 2
            nums[n1] = 1
        }else if (nums[i] == 2) {
            n2 += 1
            nums[n2] = 2
        }
    }
}
var col = [1,1,2,2,0]
sortColors(&col)
col = [0,2,2,1,1,2,2,0]
sortColors(&col)
col = [2,0,2,1,1,0]
sortColors(&col)
col = [1,0,1]
sortColors(&col)
col = [1,2,0]
sortColors(&col)
col = [0,1,1,2,2,0]
sortColors(&col)
col = [0,2,2,1]
sortColors(&col)

col = [1,1,2,2,0]
sortColors1(&col)
col = [0,2,2,1,1,2,2,0]
sortColors1(&col)
col = [2,0,2,1,1,0]
sortColors1(&col)
col = [1,0,1]
sortColors1(&col)
col = [1,2,0]
sortColors1(&col)
col = [0,1,1,2,2,0]
sortColors1(&col)
col = [0,2,2,1]
sortColors1(&col)

//148. Sort List


func quick(_ nums: inout [Int], _ lft: Int, _ rgt: Int ) {
    if lft < rgt {

        let m = lft + (rgt - lft)/2
        let mid = pivot(&nums, lft, rgt, nums[m])
        quick(&nums, lft, mid)
        quick(&nums, mid+1, rgt)
    }
}

func pivot(_ nums: inout [Int],_ left: Int, _ right: Int, _ mid: Int) -> Int {
    var l = left, r = right
    while l < r {
        if mid > nums[l] {
            l += 1
        }else if mid < nums[r] {
            r -= 1
        }else {
            nums.swapAt(l, r)
            l += 1
            r -= 1
        }
    }
    return l
}
var te = [1,3,5,7,2,4,9]
//te = [3,1,4,7,5,9,1]

//pivot(&te, 0, te.count-1, 7)
quick(&te, 0, te.count-1)
//quickSort(arr: &te, start: 0, end: te.count-1)


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
