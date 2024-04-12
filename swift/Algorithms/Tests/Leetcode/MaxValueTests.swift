//
//  MaxValueTests.swift
//  AlgorithmsTests
//
//  Created by Milton Palaguachi on 4/10/24.
//

import XCTest
@testable import Algorithms

final class MaxValueTests: XCTestCase {
    var sut: MaxValue!
    override func setUpWithError() throws {
        sut = MaxValue()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample1() throws {
        let array = [10, -2, 5, -3, 4, -1]
        let result = sut.solution(arr: array)

        let expected = 19
        XCTAssertEqual(result, expected)
    }
    
    func testExample2() throws {
        let array = [11, -2, 5, -3, 4,]
        let result = sut.solution(arr: array)
        
        let expected = 16
        XCTAssertEqual(result, expected)
    }

}
