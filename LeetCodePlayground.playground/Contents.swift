import UIKit


class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dic = [Int:Int]()
        for i in 0..<nums.count {
            if let index = dic[target - nums[i]] {
               return [index,i]
            }
            dic[nums[i]] =  i
        }
        
        return []
    }
}

class Solution1 {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int:Int]()
        for (i, n) in nums.enumerated() {
            if let index = dict[target - n] {
                return [index, i]
            }
            
            dict[n] = i
        }
        
        return []
    }
}

var testArray: [Int] = [2,2,3,4,5,6]
var test = Solution()
test.twoSum(testArray, 9)




