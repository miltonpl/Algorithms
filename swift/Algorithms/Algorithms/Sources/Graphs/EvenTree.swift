//
//  EvenTree.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 5/17/23.
//

import Foundation
/**
 - You are given a tree (a simple connected graph with no cycles).
 - Find the maximum number of edges you can remove from the tree
 to get a forest such that each connected component of the forest contains an even number of nodes.
 As an example, the following tree with  4 nodes can be cut at most 1 time to create an even forest.
 */

class EvenTree {
    struct Edge: Equatable {
        let x,y: Int
    }

    struct Node: Hashable {
        let id: Int
        var neighbors = Set<Int>()
        init(id: Int) {
            self.id = id
        }
    
        mutating func addNeighbor(_ neighbor: Int) {
            self.neighbors.insert(neighbor)
        }
    }

    // Complete the evenForest function below.
    func evenForest(t_nodes: Int, t_edges: Int, t_from: [Int], t_to: [Int]) -> Int {
        let cutEdges = 0
        let zipEdges = zip(t_from, t_to)
        var edges = [Edge]()
        var nodes = (0..<t_nodes).map { Node(id: $0) }

        for edge in zipEdges {
            let x = edge.0 - 1
            let y = edge.1 - 1
            nodes[x].addNeighbor(y)
            nodes[y].addNeighbor(x)
            edges.append(.init(x: x, y: y))
        }
        var temp = edges
        for edge in edges {
//            var filtered = temp.filter { $0 != edge }
//            var last = filtered.removeLast()
//            var setNode1 = Set<Int>()
//            setNode1.insert(last.x)
//            setNode1.insert(last.y)
//            while let first = nodes[]) {
//                setNode1.insert(first.x)
//                setNode1.insert(first.y)
//
//            }
            
            print("\(edge.x)-\(edge.y)")
        }
        for i in 0..<nodes.count {
            print("node[\(i)]->\(nodes[i].neighbors)")
        }
        
        return cutEdges
    }
}
/*
 2-1
 3-1
 4-3
 5-2
 6-1
 7-2
 8-6
 9-8
 10-8
 */
/*
 remove 2-1
 3-1
 3-4
 6-1
 8-6
 8-9
 10-8
 
 5-2
 7-2
 */
