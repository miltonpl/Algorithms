//
//  HackerRackTests.swift
//  AlgorithmsTests
//
//  Created by Milton Palaguachi on 9/28/23.
//

@testable import Algorithms
import XCTest

final class HackerRackTests: XCTestCase {


    func testTimeConversion() throws {
        let input = [
            "12:01:00PM",
            "12:01:00AM",
            "07:05:45PM"
        ]
        let expected = ["12:01:00","00:01:00","19:05:45"]
        
        for (s, y) in zip(input, expected) {
            XCTAssertEqual(timeConversion(s: s), y)
            
        }
    }
/*
 5 3
 4 3
 5 5
 4 2
 2 3
 */
    func testQueenAttack() throws {
        // Given
        let obstacles = [[5, 5], [4, 2], [2, 3]]
        // Then
        let expected = 10
        XCTAssertEqual(queensAttack(n: 5, k: 3, r_q: 4, c_q: 3, obstacles: obstacles), expected)
    }
    /*
     4 0
     4 4
     */
    
    func testQueenAttack_sample2() throws {
        // Given
        let obstacles: [[Int]] = []
        // Then
        let expected = 9
        XCTAssertEqual(queensAttack(n: 4, k: 0, r_q: 4, c_q: 4, obstacles: obstacles), expected)
    }
    /*
     1 0
     1 1
     */
    func testQueenAttack_sample3() throws {
        // Given
        let obstacles: [[Int]] = []
        // Then
        let expected = 0
        XCTAssertEqual(queensAttack(n: 1, k: 0, r_q: 1, c_q: 1, obstacles: obstacles), expected)
    }

    func testCircularRotation() throws {
        let a = [1,2,3,4,5,6,6,7,8]
        let k = 30
        print("k % a.count",k % a.count)
        print("a.count % k",a.count % k )
    }

    func testPermutationEquation() {
        let p = [5,2,1,3,4]
        let result = permutationEquation(p: p)
        let y = [4,2,5,1,3]
        XCTAssertEqual(y, result)
        let p2 = [2, 3, 1]
        let result2 = permutationEquation(p: p2)
        let y2 = [2,3,1]
        XCTAssertEqual(y2, result2)
    }
}
