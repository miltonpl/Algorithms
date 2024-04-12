//
//  TwoSum.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/1/24.
//

import Foundation
/*
 Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

 You may assume that each input would have exactly one solution, and you may not use the same element twice.

 You can return the answer in any order.
 */
/*
 Example 1:

 Input: nums = [2,7,11,15], target = 9
 Output: [0,1]
 Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
 Example 2:

 Input: nums = [3,2,4], target = 6
 Output: [1,2]
 Example 3:

 Input: nums = [3,3], target = 6
 Output: [0,1]
 */
class TwoSum {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dic = [Int: Int]()//
        for index in 0..<nums.count {//O(n)
            let value = nums[index]
            let reminder = target - value
            if let anotherIndex  = dic[reminder] {
                return [anotherIndex, index]
            }
            dic[value] = index
        }
        return [-1, -1]
    }
}

// Time complexity: O(n)
// space complesity: O(n) + O(3) 
