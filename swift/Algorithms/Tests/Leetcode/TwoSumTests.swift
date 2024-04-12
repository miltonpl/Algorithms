//
//  TwoSumTests.swift
//  AlgorithmsTests
//
//  Created by Milton Palaguachi on 4/1/24.
//

import XCTest
@testable import Algorithms

final class TwoSumTests: XCTestCase {

    func testTwoSumSet1() throws {
    // Input
        let nums = [2,7,11,15], target = 9
    // Output:
        let indices = [0,1]
        let result = TwoSum().twoSum(nums, target)
        XCTAssertEqual(result.first, indices.first)
        XCTAssertEqual(result.last, indices.last)
    }

    func testTwoSumSet2() throws {
    // Input
        let nums = [1,2,7,11,15], target = 9
    // Output:
        let indices = [1,2]
        let result = TwoSum().twoSum(nums, target)
        XCTAssertEqual(result.first, indices.first)
        XCTAssertEqual(result.last, indices.last)
    }

    func testTwoSumSet3() throws {
    // Input
        let nums = [3,2,4], target = 6
    // Output:
        let indices = [1,2]
        let result = TwoSum().twoSum(nums, target)
        XCTAssertEqual(result.first, indices.first)
        XCTAssertEqual(result.last, indices.last)
    }

    func testTwoSumSet4() throws {
    // Input
        let nums = [3,3], target = 6
    // Output:
        let indices = [0,1]
        let result = TwoSum().twoSum(nums, target)
        XCTAssertEqual(result.first, indices.first)
        XCTAssertEqual(result.last, indices.last)
    }

    // [-1,-2,-3,-4,-5]
    func testTwoSumSet5() throws {
    // Input
        let nums = [-1,-2,-3,-4,-5], target = -8
    // Output:
        let expected = [2,4]
        let result = TwoSum().twoSum(nums, target)
        XCTAssertEqual(expected, result)
    }
}
