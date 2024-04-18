//
//  AddOneRow.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/17/24.
//

import Foundation

//  Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?

    public init() {
        self.val = 0;
        self.left = nil;
        self.right = nil;
    }

    public init(_ val: Int) {
        self.val = val; 
        self.left = nil;
        self.right = nil;
    }

    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}
/**
 
 Given the root of a binary tree and two integers val and depth, add a row of nodes with value val at the given depth depth.

 Note that the root node is at depth 1.

 The adding rule is:

 - Given the integer depth, for each not null tree node cur at the depth depth - 1, create two tree nodes with value val as cur's left subtree root and right subtree root.
 - cur's original left subtree should be the left subtree of the new left subtree root.
 - cur's original right subtree should be the right subtree of the new right subtree root.
 - If depth == 1 that means there is no depth depth - 1 at all, then create a tree node with value val as the new root of the whole original tree, and the original tree is the new root's left subtree.
 */
class AddOneRow {
    func solution(_ root: TreeNode?, _ val: Int, _ depth: Int) -> TreeNode? {
        guard let root = root else { return nil }
        switch depth {
            case 1:
                let node = TreeNode(val)
                node.left = root
                return node
            case 2:
                let leftNode = TreeNode(val), rightNode = TreeNode(val)
                leftNode.left = root.left
                rightNode.right = root.right
                root.right = rightNode
                root.left = leftNode
                return root
            default:
                if let right = root.right {
                    solution(right, val, depth - 1)
                }
                if let left = root.left{
                    solution(left, val, depth - 1)
                }
                return root
        }
    }

    func mySolution(_ root: TreeNode?, _ val: Int, _ depth: Int) -> TreeNode? {
            func iterate(_ root: TreeNode, _ val: Int, _ depth: Int) {
              guard depth > 0 else {
                  let nodeLeft = TreeNode(val)
                  let nodeRight = TreeNode(val)

                  if let right = root.right {
                      nodeRight.right = right
                  }

                  if let left = root.left {
                      nodeLeft.left = left
                  }
                  root.left = nodeLeft
                  root.right = nodeRight
                
                  return
              }

              if let right = root.right {
                  iterate(right, val, depth - 1)
              }

              if let left = root.left {
                  iterate(left, val, depth - 1)
              }
          }
          guard let root = root else { return nil }
          guard depth > 0 else {
              return root
          }
      
          if depth == 1 {
              let node = TreeNode(val)
              node.left = root
              return node
          }

          iterate(root, val, depth - 2)
          return root
      }

    func makeTree(_ nums: [Int]) -> TreeNode? {
        guard !nums.isEmpty else {
            return nil
        }

        let root = TreeNode(nums[0])
        for i in 1..<nums.count {
            iterate(value: nums[i], root: root)
        }
        return root
    }

    func iterate(value: Int, root: TreeNode) {
        if value < root.val {
            if let right = root.right {
                iterate(value: value, root: right)
            } else {
                root.right = TreeNode(value)
            }
        } else {
            if let left = root.left {
                iterate(value: value, root: left)
            } else {
                root.left = TreeNode(value)
            }
        }
    }
}
