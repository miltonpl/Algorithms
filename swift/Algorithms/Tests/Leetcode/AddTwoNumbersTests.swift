//
//  AddTwoNumbersTests.swift
//  AlgorithmsTests
//
//  Created by Milton Palaguachi on 4/3/24.
//

import XCTest
@testable import Algorithms

final class AddTwoNumbersTests: XCTestCase {

    func testExample() throws {
        let l1 = createList(for: [2,4,3])
        let l2 = createList(for: [5,6,4])
        let expected = createList(for: [7,0,8])
        let result = AddTwoNumbers().solutionII(l1, l2)
        dump(expected)
        dump(result)
        XCTAssertEqual(expected, result)
    }

    func createList(for array: [Int]) -> ListNode? {
        guard let val = array.first else {
            return nil
        }
        let node = ListNode(val)
        var tpNode = node
        for index in 1..<array.count {
            let newNode = ListNode(array[index])
            tpNode.next = newNode
            tpNode = newNode
        }
        return node
    }

}

extension ListNode: Equatable {
    public static func == (lhs: Algorithms.ListNode, rhs: Algorithms.ListNode) -> Bool {
        switch (lhs, rhs) {
            case (let l, let r):
                return l.val == r.val
        }
    }
}
