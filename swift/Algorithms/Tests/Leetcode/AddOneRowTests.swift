//
//  AddOneRowTests.swift
//  AlgorithmsTests
//
//  Created by Milton Palaguachi on 4/17/24.
//

import XCTest
@testable import Algorithms

final class AddOneRowTests: XCTestCase {
    var sut: AddOneRow!
    override func setUpWithError() throws {
        sut = AddOneRow()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testExample() throws {
        let nums = [4,2,6,3,1,5]
        let root = sut.makeTree(nums)
        let newRoot = sut.solution(root, 1, 2)
        dump(newRoot)
      }
}
