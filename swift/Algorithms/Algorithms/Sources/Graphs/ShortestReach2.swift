//
//  ShortestReach.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/19/23.
//

// Dijkstra: Shortest Reach 2
// BSF Algorithm
/*
 * Complete the 'shortestReach' function below.
 *
 * The function is expected to return an INTEGER_ARRAY.
 * The function accepts following parameters:
 *  1. INTEGER n
 *  2. 2D_INTEGER_ARRAY edges
 *  3. INTEGER s
 */
 // https://www.hackerrank.com/challenges/dijkstrashortreach/problem?utm_campaign=challenge-recommendation&utm_medium=email&utm_source=24-hour-campaign
/*
 Given an undirected graph and a starting node, determine the lengths of the shortest paths from the starting node to all other nodes in the graph. If a node is unreachable, its distance is -1. Nodes will be numbered consecutively from  to , and edges will have varying distances or lengths.
 For example, consider the following graph of 5 nodes:
 */
import Foundation

class ShortestReach2 {
    
    struct Edge {
        var z,w: Int
    }

    struct Queue {
        var array = [Int]()

        var isEmpty: Bool {
            array.isEmpty
        }

        mutating func enqueue(_ value: Int) {
            array.append(value)
        }

        mutating func dequeue() -> Int? {
            return isEmpty ? nil : array.removeFirst()
        }
    }

    func shortestReach(n: Int, edges: [[Int]], s: Int) -> [Int] {
        var dic = [Int: [Edge]]()
        for edge in edges {
            let x = edge[0] - 1
            let y = edge[1] - 1
            let w = edge[2]

            if var value = dic[x] {
                value.append(.init(z: y, w: w))
                dic[x] = value
            } else {
                dic[x] = [.init(z: y, w: w)]
            }
            if var value = dic[y] {
                value.append(.init(z: x, w: w))
                dic[y] = value
            } else {
                dic[y] = [.init(z: x, w: w)]
            }
        }
        var queue = Queue()
        var dist = Array(repeating: -1, count: n)
        var visited = Array(repeating: false, count: n)
        let start = s - 1
        queue.enqueue(start)
        visited[start] = true
        dist[start] = 0
        while let p = queue.dequeue() {
            if let neighbors = dic[p] {
                for neighbor in neighbors {
                      if visited[neighbor.z] == false || dist[neighbor.z] > (dist[p] + neighbor.w) {
                          queue.enqueue(neighbor.z)
                          dist[neighbor.z] = dist[p] + neighbor.w
                          visited[neighbor.z] = true
                    }
                }
            }
        }
        dist.remove(at: start)
        return dist
    }
}
