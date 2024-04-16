//
//  GetMaxAdditionalDinersCount.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/7/24.
//

import Foundation
struct GetMaxAdditionalDinersCount {
    
    // N: Number of rows
    // K: seats to the right
    // K : seats to the left
    // M: Diner seated at the table
    // Si: Seat
    /*
     N; Number of seats
     K: distance factor
     M: Number of seats taken
     S: Seats taken
     */
    
/*
  N = 10
  K = 1
  M = 3
  S = [2, 6, 9]
  return 1
rows: o1,x2,o3,o4,o5,x6,o7,o8,x9,o10,
 o,o,o,o,x,o,o,o
 k=2
 1 + r/(k + 1) = 1 +(n - 1)/(k+1) = 1 + 4/3= 2
 */

    //4 - 4
// (10 - 8)/(2) + 1 = 2/2 + 1= 2
    // Valid solution
    /// ref: https://www.youtube.com/watch?v=zdHjq8ezHV0&t=901s
    func solution(N: Int, K: Int, M: Int, S: [Int]) -> Int {
        let seatsTaken = S.sorted()
        var extraSpace = 0
        var firstOpenSeat = 1
        var openSeat = 0
        for takenSeat in seatsTaken {
            openSeat = takenSeat - K - firstOpenSeat
            if openSeat > 0 {
                let result = ceil(Double(openSeat)/Double(K + 1))
                extraSpace += Int(result)
            }
            firstOpenSeat = takenSeat + K + 1
        }
        openSeat = N + 1 - firstOpenSeat
        if openSeat > 0 {
            let result = ceil(Double(openSeat)/Double(K + 1))
            extraSpace += Int(result)
        }
      
        return extraSpace
    }
}

