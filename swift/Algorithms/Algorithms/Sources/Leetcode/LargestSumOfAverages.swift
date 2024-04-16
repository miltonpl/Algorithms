//
//  LargestSumOfAverages.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/10/24.
//

// ref: https://leetcode.com/problems/largest-sum-of-averages/description/

import Foundation
/*
 813. Largest Sum of Averages
 Medium

 You are given an integer array nums and an integer k. You can partition the array into at most k non-empty adjacent subarrays. The score of a partition is the sum of the averages of each subarray.

 Note that the partition must use every integer in nums, and that the score is not necessarily an integer.

 Return the maximum score you can achieve of all the possible partitions. Answers within 10-6 of the actual answer will be accepted.
 */
class LargestSumOfAverages {
    func solution(_ nums: [Int], _ k: Int) -> Double {
           
           var memo: [[Double]] = Array(
               repeating: Array(repeating: -1.0, count: k + 1),
               count: nums.count
           )

           func partition(_ index: Int, _ k: Int) -> Double {
               if index >= nums.count { return 0.0 }
               if k == 0 { return -1000000000.0 }

               if memo[index][k] != -1.0 {
                   return memo[index][k]
               }

               var sum = 0
               memo[index][k] = 0.0
               for i in index..<nums.count {
                   sum += nums[i]
                   memo[index][k] = max(
                       memo[index][k],
                       partition(i + 1, k - 1) + (Double(sum) / Double(i - index + 1))
                   )
               }

               return memo[index][k]
           }

           return partition(0, k)
       }
}
