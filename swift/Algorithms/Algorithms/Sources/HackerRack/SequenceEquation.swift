//
//  SequenceEquation.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 10/9/23.
//

import Foundation
/*
 Given a sequence of  integers, p(1), p(2),...,p(n) where each element is distinct and satisfies 1<=P(x)<=n.
For each where 1 <= x <= n, that is x increments from 1 to n, find any integer y such that p(p(y)) = x
 and keep a history of the values of y in a return array.
Exmple
 p=[5,2,1,3,4]
 Each value of  between  and , the length of the sequence, is analyzed as follows:
 1. x = 1 ~ p[3],
 2. x = 2 ~ p[2],
 3. x = 3 ~ p[4],
 4. x = 4 ~ p[5]
 The values for  are .
 Fu
 */
/*
 * Complete the 'permutationEquation' function below.
 *
 * The function is expected to return an INTEGER_ARRAY.
 * The function accepts INTEGER_ARRAY p as parameter.
 */
//p=[5,2,1,3,4]
func permutationEquation(p: [Int]) -> [Int] {
    // Write your code here
    var history: [Int: Int] = [:]
    for i in 0..<p.count {
        history[i + 1] = p[i]
    }
    let h = history.sorted { $0.value < $1.value }
    var result = [Int]()
    for (key, _) in h {
        result.append((p.firstIndex(of: key) ?? 0) + 1)
    }
    return result
}
