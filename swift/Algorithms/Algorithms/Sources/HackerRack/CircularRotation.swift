//
//  CircularRotation.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 10/5/23.
//

import Foundation
/*
 John Watson knows of an operation called a right circular rotation on an array of integers. One rotation operation moves the last array element to the first position and shifts all remaining elements right one. To test Sherlock's abilities, Watson provides Sherlock with an array of integers. Sherlock is to perform the rotation operation a number of times then determine the value of the element at a given position.
 For each array, perform a number of right circular rotations and return the values of the elements at the given indices.
 Example
  
  

 Here  is the number of rotations on , and  holds the list of indices to report. First we perform the two rotations:
 Now return the values from the zero-based indices  and  as indicated in the  array.
 a = [1,2,3]
 k = 2
 q = [0,1,2]
 Explanation 0
 After the first rotation, the array is [3,1,2]
 After the second (and final) rotation, the array is [2,3,1]
 We will call this final state array [2,3,1]. For each query, we just have to get the value of .

 */
func circularArrayRotation(a: [Int], k: Int, queries: [Int]) -> [Int] {
    // Write your code here
    let i = k % a.count
    var b = a
    for index in 0..<a.count {
        let u = index + i
        if u < a.count {
            b[u] = a[index]
        } else {
            let newU = u % a.count
            b[newU] = a[index]
        }
    }
    return queries.map{b[$0]}
}
