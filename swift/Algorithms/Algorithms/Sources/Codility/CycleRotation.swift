//
//  CycleRotation.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/25/23.
//

import Foundation
//ref: https://app.codility.com/programmers/lessons/2-arrays/cyclic_rotation/
/*
 An array A consisting of N integers is given. Rotation of the array means that each element is shifted right by one index, and the last element of the array is moved to the first place. For example, the rotation of array A = [3, 8, 9, 7, 6] is [6, 3, 8, 9, 7] (elements are shifted right by one index and 6 is moved to the first place).
 */
class CycleRotation {
    public func solution(_ A : inout [Int], _ K : Int) -> [Int] {
        // Implement your solution here
        let lastIndex = A.count - 1
        let k = A.count % K
        if k == 0 { return A }

        var result = [Int]()
    
        for i in 0..<A.count {
            result.append(A[lastIndex - (k + i)])
        }
        return result
    }
    
}

