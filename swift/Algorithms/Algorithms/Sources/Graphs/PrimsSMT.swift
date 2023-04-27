//
//  PrimsSMT.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/19/23.
//

import Foundation

// Prime's Algorithme ref: https://en.wikipedia.org/wiki/Prim%27s_algorithm
// next algorithm: https://en.wikipedia.org/wiki/Borůvka%27s_algorithm
/**
 Prim's (MST) : Special Subtree
 
 Given a graph which consists of several edges connecting its nodes, find a subgraph of the given graph with the following properties:
 
 1. The subgraph contains all the nodes present in the original graph.
 2. The subgraph is of minimum overall weight (sum of all edges) among all such subgraphs.
 3. It is also required that there is `exactly one, exclusive` path between any two nodes of the subgraph.
 One specific node  is fixed as the starting point of finding the subgraph using Prim's Algorithm.
 Find the total weight or the sum of all edges in the subgraph.
  Example
 n = 3
 edges = [[1,2,3],[2,3,2],[1,3,2]]
 start = 1
 */
/*
 * Complete the 'prims' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts following parameters:
 *  1. INTEGER n
 *  2. 2D_INTEGER_ARRAY edges
 *  3. INTEGER start
 */
// Input

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

class PrimsMST {
    struct Queue {
        var nodes = [Int]()

        mutating func enqueue(node: Int) {
            nodes.append(node)
        }

        mutating func dequeue() -> Int? {
            return nodes.isEmpty ? nil : nodes.removeFirst()
        }
    }

    struct Edge {
        var x,y,w: Int
    }

    struct Neighbor: Hashable {
        var z, w: Int
    }

    struct Node {
        var id: Int
        var neighbors = Set<Neighbor>()

        init(id: Int) {
            self.id = id
        }
    
        mutating func addNeighbor(_ neighbor: Neighbor) {
            self.neighbors.insert(neighbor)
        }
    }

    func prims(n: Int, edges: [[Int]], start: Int) -> Int {
        // Write your code here
        var nodes = (0..<n).map { Node(id: $0) }
        var visited = Array(repeating: false, count: n)
        var dist = Array(repeating: Int.max, count: n)
        var path = [Edge]()
        var queue = Queue()
        for edge in edges {
            let x = edge[0] - 1
            let y = edge[1] - 1
            let w = edge[2]
            nodes[x].addNeighbor(.init(z: y, w: w))
            nodes[y].addNeighbor(.init(z: x, w: w))
        }
        queue.enqueue(node: start - 1)
        visited[start - 1] = false
        dist[start - 1] = 0
        while let node = queue.dequeue() {
            let neighbors = nodes[node].neighbors
             for neighbor in neighbors {
                 if visited[neighbor.z] == false || (dist[node] + neighbor.w) < dist[neighbor.z] {
                    queue.enqueue(node: neighbor.z)
                    visited[neighbor.z] = true
                     dist[neighbor.z] = dist[node] + neighbor.w

//                     if !path.contains(where: { ($0.x == node && $0.y == neighbor.z || $0.x == neighbor.z && $0.y == node) && $0.w == neighbor.w }) {
//                         path.append(.init(x: node, y: neighbor.z, w: neighbor.w))
//                     }
                }
            }
        }

        for edge in path {
            print("edge: \(edge)")
        }
        
        for i in 0..<dist.count {
            print("dist[\(i + 1)] = \(dist[i])")
        }

        return path.reduce(0) { $0 + $1.w}
    }
}

