//
//  MaxValue.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/10/24.
//

import Foundation
/*
 Facebook interview:
 
 Given an integer array arr, we define value v over a partition of arr as sum of maximum of
 "each part of arr after partition",
 such that each part must contain atleast 1 negative number


 Maximum value is given by partition:
 [10, -2] [5, -3] [4, -1]
 10 + 5 + 4
 19 is the answer

 Now we want to find maximum value of arr
 O(N*N) approach is straightforward, any better approach?
 */

struct MaxValue {
    func mysolution(arr: [Int]) -> Int {
        var negativeArray = [Int]()
        var positiveArray = [Int]()
        var result = 0
        for num in arr {
            if num < 0 {
                negativeArray.append(num)
            } else {
                positiveArray.append(num)
            }
        }
        let sortedPositives = positiveArray.sorted { $0 > $1 }
        if negativeArray.count <= positiveArray.count {
            for i in 0..<negativeArray.count {
                result += sortedPositives[i]
            }
        } else {
            result = positiveArray.reduce(0, { $0 + $1 })
        }
        return result
    }

    func solution(arr: [Int]) -> Int {
        let sortedArr = arr.sorted { $0 > $1 }

        var negativeCount = 0
        var positiveCount = 0
        var result = 0
        for num in arr {
            if num < 0 {
                negativeCount += 1
            } else {
                negativeCount += 1
            }
        }
        return -1
    }
}
