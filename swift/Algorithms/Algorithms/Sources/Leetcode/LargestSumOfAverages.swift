//
//  LargestSumOfAverages.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/10/24.
//

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
        let sortedNums = nums.sorted{ $0 > $1 }
        var result = 0.0
        var count = 0
        var total = 0
        for i in 0..<sortedNums.count {
            if i < (k - 1) {
            result += Double(sortedNums[i])
            } else {
                total += sortedNums[i]
                count += 1
            }
        }
        //[4,1,7,5,6,2,3]
        if total > 0 {
            result += Double(total)/Double(count)
        }
        return result
    }
}
