//
//  KruskalsMST.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/19/23.
//

// Kruskal (MST): Really Special Subtree
// https://en.wikipedia.org/wiki/Kruskal%27s_algorithm
// https://www.youtube.com/watch?v=kUMaslI7O3c
// ref: https://github.com/alexprut/HackerRank/blob/master/Algorithms/Graph%20Theory/Kruskal%20MST%20Really%20Special%20Subtree/Solution.java
/*
 
 Given an undirected weighted connected graph, find the Really Special SubTree in it. The Really Special SubTree is defined as a subgraph consisting of all the nodes in the graph and:
 There is only one exclusive path from a node to every other node.
 The subgraph is of minimum overall weight (sum of all edges) among all such subgraphs.
 No cycles are formed
 To create the Really Special SubTree, always pick the edge with smallest weight. Determine if including it will create a cycle. If so, ignore the edge. If there are edges of equal weight available:
 Choose the edge that minimizes the sum  where  and  are vertices and  is the edge weight.
 If there is still a collision, choose any of them.
 Print the overall weight of the tree formed using the rules.
 For example, given the following edges:
 
 */
/*
 Input Format
 The first line has two space-separated integers  and , the number of nodes and edges in the graph.
 The next  lines each consist of three space-separated integers ,  and , where  and  denote the two nodes between which the undirected edge exists and  denotes the weight of that edge.
 Input
 
 4 6
 1 2 5
 1 3 3
 4 1 6
 2 4 7
 3 2 4
 3 4 5
 */
/*
 * Complete the 'kruskals' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts WEIGHTED_INTEGER_GRAPH g as parameter.
 */

/*
 * For the weighted graph, <name>:
 *
 * 1. The number of nodes is <name>Nodes.
 * 2. The number of edges is <name>Edges.
 * 3. An edge exists between <name>From[i] and <name>To[i]. The weight of the edge is <name>Weight[i].
 *
 */
//Minimal Spanning Tree
// |e| = n - 1

/*
 let input2 = [
     [1, 2, 1],
     [3, 2, 150],
     [4, 3, 99],
     [1, 4, 100],
     [3, 1, 200],
 ]
 
 
  input2
  Expected Output
  200

 */
import Foundation

class KruskalsMST {
    struct Node {
        let id: Int
        var members = Set<Int>()

        init(id: Int) {
            self.id = id
            self.members.insert(id)
        }

        func contains(member: Int) -> Bool {
            members.contains(member)
        }
    }
   
    struct Edge {
        let x,y,w: Int
    }

    func kruskals(gNodes: Int, gFrom: [Int], gTo: [Int], gWeight: [Int]) -> Int {
        // Write your code here
        var edges = [Edge]()
        var path = [Edge]()
        var nodes = [Node]()

        for i in 0..<gNodes {
            nodes.append(.init(id: i))
        }

        for i in 0..<gFrom.count {
            let x = gFrom[i] - 1
            let y = gTo[i] - 1
            let w = gWeight[i]
            edges.append(.init(x: x, y: y, w: w))
        }
        edges.sort{ $0.w < $1.w}
        
    
        for edge in edges {
            let x = nodes[edge.x]
            let y = nodes[edge.y]
            if !x.contains(member: y.id) {
                path.append(edge)
                let m = x.members.union(y.members) // union joins to sets
                var itirator = m
                while let current = itirator.popFirst() {
                    nodes[current].members = m // assing m to current node member
                }
            }
        }
        return path.reduce(0) { $0 + $1.w}
    }
}
