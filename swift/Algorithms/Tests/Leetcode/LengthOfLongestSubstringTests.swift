//
//  LengthOfLongestSubstringTests.swift
//  AlgorithmsTests
//
//  Created by Milton Palaguachi on 4/4/24.
//

import XCTest
@testable import Algorithms

final class LengthOfLongestSubstringTests: XCTestCase {
    var sut: LengthOfLongestSubstring!
    override func setUpWithError() throws {
        sut = LengthOfLongestSubstring()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test1() throws {
        let s = "abcabcbb"
        let expected = 3
        XCTAssertEqual(sut.solution(s), expected)
    }
    func test2() throws {
        let s = "bbbbbb"
        let expected = 1
        XCTAssertEqual(sut.solution(s), expected)
    }
    func test3() throws {
        let s = "pwwkew"
        let expected = 3
        XCTAssertEqual(sut.solution(s), expected)
    }

    func test4() throws {
        let s = "dvdf"
        let expected = 3
        XCTAssertEqual(sut.solution(s), expected)
    }
}
