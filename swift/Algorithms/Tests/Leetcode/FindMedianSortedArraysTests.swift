//
//  FindMedianSortedArraysTests.swift
//  AlgorithmsTests
//
//  Created by Milton Palaguachi on 4/6/24.
//

import XCTest
@testable import Algorithms

final class FindMedianSortedArraysTests: XCTestCase {
    var sut: FindMedianSortedArrays!

    override func setUpWithError() throws {
        sut = FindMedianSortedArrays()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test1() throws {
        let nums1 = [1,3], nums2 = [2]
        let expected = 2.0
        let result = sut.solution(nums1, nums2)
        XCTAssertEqual(result, expected)
    }
    func test2() throws {
        let  nums1 = [1,2], nums2 = [3,4]
        let expected = 2.5
        let result = sut.solution(nums1, nums2)
        XCTAssertEqual(result, expected)
    }
    func test3() throws {
        let  nums1 = [3,6,8], nums2 = [4,7,9]
        let expected = 6.5
        let result = sut.solution(nums1, nums2)
        XCTAssertEqual(result, expected)
    }

}
