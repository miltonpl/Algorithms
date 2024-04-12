//
//  MergeIntervalsTests.swift
//  AlgorithmsTests
//
//  Created by Milton Palaguachi on 4/10/24.
//

import XCTest
@testable import Algorithms

final class MergeIntervalsTests: XCTestCase {
    var sut: MergeIntervals!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = MergeIntervals()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func test1() throws {
        let intervals = [[1,3],[2,6],[8,10],[15,18]]
        let result = sut.solution(intervals: intervals)
        let expected =  [[1,6],[8,10],[15,18]]
        XCTAssertEqual(result, expected)
    }
    
    func test2() throws {
        let intervals = [[1,4],[4,5]]
        let result = sut.solution(intervals: intervals)
        let expected =  [[1,5]]
        XCTAssertEqual(result, expected)
    }
    
    func test3() throws {
        let intervals = [[1,4],[2,3]]
        let result = sut.solution(intervals: intervals)
        let expected =  [[1,4]]
        XCTAssertEqual(result, expected)
    }
}
