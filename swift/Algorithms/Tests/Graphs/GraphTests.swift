//
//  GraphTests.swift
//  AlgorithmsTests
//
//  Created by Milton Palaguachi on 4/19/23.
//

import XCTest
@testable import Algorithms


final class GraphTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLightsOutStyleGame() throws {
        // Given
        let game = LightsOutStyleGame()
        // When
        game.grid(x: 10, y: 10, tappedX: 4, tappedY: 4)
        // Then
    }

    func testShortestReach2() throws {
        // Given
        let edges = [
            [1, 2, 24],
            [1, 4, 20],
            [3, 1, 3],
            [4, 3, 12]
        ]
        let path = ShortestReach2()

        // When
        let dist = path.shortestReach(n: 4, edges: edges, s: 1)
       
        // Then
        let expectd = [24, 3, 15]
        for i in dist {
            if !expectd.contains(i) {
                XCTFail("not in \(i)")
            }
        }
    }
    
    func testKruskalsMST_sample1() throws {
        // Given
        let kruskalsMST = KruskalsMST()
        let edges: [[Int]] = [
            [1, 2, 5],
            [1, 3, 3],
            [4, 1, 6],
            [2, 4, 7],
            [3, 2, 4],
            [3, 4, 5]
        ]

        // When
        var gFrom = [Int]()
        var gTo = [Int]()
        var gWeight = [Int]()
        for edge in edges {
            gFrom.append(edge[0])
            gTo.append(edge[1])
            gWeight.append(edge[2])
        }
        let result = kruskalsMST.kruskals(gNodes: 4, gFrom: gFrom, gTo: gTo, gWeight: gWeight)

        // Then
        let expected = 12
        XCTAssertEqual(result, expected)
    }

    func testKruskalsMST_sample2() throws {
        // Given
        let kruskalsMST = KruskalsMST()
        let edges = [
            [1, 2, 1],
            [3, 2, 150],
            [4, 3, 99],
            [1, 4, 100],
            [3, 1, 200]
        ]
        // When
        var gFrom = [Int]()
        var gTo = [Int]()
        var gWeight = [Int]()
        for edge in edges {
            gFrom.append(edge[0])
            gTo.append(edge[1])
            gWeight.append(edge[2])
        }
        let result = kruskalsMST.kruskals(gNodes: 4, gFrom: gFrom, gTo: gTo, gWeight: gWeight)

        // Then
        let expected = 200
        XCTAssertEqual(result, expected)
    }
    /*
     /*
      5 6
      1 2 3
      1 3 4
      4 2 6
      5 2 2
      2 3 5
      3 5 7
      1
      */
     */
    func testPrims() throws {
        let prim = PrimsMST()
        let edges = [
            [1, 2, 3],
            [1, 3, 4],
            [4, 2, 6],
            [5, 2, 2],
            [2, 3, 5],
            [3, 5, 7]
        ]
        let result = prim.prims(n: 5, edges: edges, start: 1)
        XCTAssertEqual(result, 15)
    }
    /*
     5 7
     1 2 20
     1 3 50
     1 4 70
     1 5 90
     2 3 30
     3 4 40
     4 5 60
     2
     Expected: 150
     */
    func testPrims2() throws {
        let prim = PrimsMST()
        let edges = [
            [1, 2, 20],
            [1, 3, 50],
            [1, 4, 70],
            [1, 5, 90],
            [2, 3, 30],
            [3, 4, 40],
            [4, 5, 60]
        ]
    let result = prim.prims(n: 5, edges: edges, start: 2)
        XCTAssertEqual(result, 150)
    }

    func testEvenTree() throws {
        // Given
        let evenTree = EvenTree()
        let nodes = 10
        let edges = 9
        let fromEdg = [2,3,4,5,6,7,8,9,10]
        let toEdg = [1,1,3,2,1,2,6,8,8]

        // When
        let result = evenTree.evenForest(
            t_nodes: nodes,
            t_edges: edges,
            t_from: fromEdg,
            t_to: toEdg
        )

        // Then
        let expectedCutEdges = 2
        XCTAssertEqual(result, expectedCutEdges)
    }
}

