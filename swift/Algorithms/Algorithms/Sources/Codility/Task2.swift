//
//  Task2.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/26/23.
//

import Foundation
// Find the min value that is not in the array, the min value must be greater than zero
// A = [1, 2, 3, 4, 6], the min = 5
// B = [-1,-3], the min = 1
// C = [1,2,3], the min = 4

class Task2 {
    public func solution(_ A : inout [Int]) -> Int {
        // Implement your solution here
        let set1 = Set(A)
        var array = Array(set1)
        array.sort()
        var min = 0
        for i in 0..<array.count {
            min += 1
            
            if min < array[i] {
                return min
            }
            
        }
        let last = (array.last ?? 0)
        return  last > 0 ? last + 1 : 1
    }
}

