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
