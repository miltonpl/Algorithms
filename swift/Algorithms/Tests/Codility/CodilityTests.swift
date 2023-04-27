//
//  CodilityTests.swift
//  AlgorithmsTests
//
//  Created by Milton Palaguachi on 4/25/23.
//

@testable import Algorithms
import XCTest

final class CodilityTests: XCTestCase {
/*
 1
 10
 1001
 100000
 10010011
 111100011
 1000010001
 1010000111
 10000010001
 */
    func testBinaryGap() throws {
        let expected = [
            1: 0,
            2: 0,
            9: 2,
            32: 0,
            147:2,
            483:3,
            529: 4,
            647: 4,
            1041: 5
        ]
        let binaryGap = BinaryGap()
        for i in [1, 2,9, 32, 147, 483, 529, 647,1041] {
            XCTAssertEqual(binaryGap.solution(n: i), expected[i])
        }
    }
    func testTask2() throws {
        let task2 = Task2()
        var some = [1, 3, 6, 4, 1, 2]
        XCTAssertEqual(task2.solution(&some), 5)
    }
    
    func testTask21() throws {
        let task2 = Task2()
        var some = [1, 2, 3]
        XCTAssertEqual(task2.solution(&some), 4)
    }
    func testInteractiveBrokers() throws {
        typealias Sample = (String, Int)
        var samples = [Sample]()
        samples.append(("v<<<vv^^", 5))
        samples.append(("<<^<<^<vv>>", 6))
        samples.append(("vvv^", 1))
        samples.append(("^^", 0))
        samples.append(("^^<<", 2))
        samples.append(("v>>>vv", 3))

        let ib = InteractiveBrokers()
        for sample in samples {
            XCTAssertEqual(ib.solution2(sample.0),sample.1)
        }
    }
}
