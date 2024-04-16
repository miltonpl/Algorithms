//
//  GetMaxAdditionalDinersCountTests.swift
//  AlgorithmsTests
//
//  Created by Milton Palaguachi on 4/7/24.
//

import XCTest
@testable import Algorithms

final class GetMaxAdditionalDinersCountTests: XCTestCase {
    var sut: GetMaxAdditionalDinersCount!
    override func setUpWithError() throws {
        sut = GetMaxAdditionalDinersCount()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
/*
 N = 15
 K = 2
 M = 3
 S = [11, 6, 14]
 return 1
 */
    /*
     - o - x - o - x - x
     */
    func test1() throws {
        let result = sut.solution(N: 10, K: 1, M: 2, S: [2,6])
        XCTAssertEqual(result, 3)
    }
}
