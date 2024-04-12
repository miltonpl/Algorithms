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
        let array = [4,1,7,5,6,2,3]
        let k = 4
        let result = sut.solution(array, k)
        
        let expected = 18.16667
        XCTAssertEqual(result, expected)
    }
}
