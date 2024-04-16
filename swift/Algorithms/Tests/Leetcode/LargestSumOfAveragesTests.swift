//
//  LargestSumOfAveragesTests.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/10/24.
//

import XCTest
@testable import Algorithms

final class LargestSumOfAveragesTests: XCTestCase {
    var sut: LargestSumOfAverages!
    override func setUpWithError() throws {
        sut = LargestSumOfAverages()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample1() throws {
        let array = [9,1,2,3,9]
        let k = 3
        let result = sut.solution(array, k)
        
        let expected = 20.00000
        XCTAssertEqual(result, expected)
    }

    func testExample3() throws {
        let array = [4,1,7,5,6,2,3]
        // (4 + 1)/2 = 2.5
        // 7 + 5 = 12
        // (6 + 2 + 3)/3 =11/3 = 3.667
        // = 18.333
        let k = 4
        let result = sut.solution(array, k)
        
        let expected = 18.16667
        XCTAssertEqual(result.rounded(), expected.rounded())
    }
}
