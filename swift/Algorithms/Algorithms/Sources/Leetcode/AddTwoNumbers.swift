//
//  AddTwoNumbers.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/3/24.
//

import Foundation

 // Definition for singly-linked list.
/*
 You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

 You may assume the two numbers do not contain any leading zero, except the number 0 itself.


 */
/*
 
Input: l1 = [2,4,3], l2 = [5,6,4]
Output: [7,0,8]
Explanation: 342 + 465 = 807.
Example 2:

Input: l1 = [0], l2 = [0]
Output: [0]
Example 3:

Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
Output: [8,9,9,9,0,0,0,1]


Constraints:

The number of nodes in each linked list is in the range [1, 100].
0 <= Node.val <= 9
It is guaranteed that the list represents a number that does not have leading zeros.
*/
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class AddTwoNumbers {
    func solutionI(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var sum = (l1?.val ?? 0) + (l2?.val ?? 0)
        var carry = sum/10
        var reminder = sum % 10
        let node = ListNode(reminder)
        var tpNode = node
        var tpL1 = l1, tpL2 = l2
        while(tpL1?.next != nil || tpL2?.next != nil) {
            tpL1 = tpL1?.next
            tpL2 = tpL2?.next

            sum = (tpL1?.val ?? 0) + (tpL2?.val ?? 0) + carry
            let currentCarry = sum/10
            reminder = sum % 10
            let newNode = ListNode(reminder + carry)
            tpNode.next = newNode
            tpNode = newNode
            carry = currentCarry
        }
        if carry > 0 {
            let newNode = ListNode(carry)
            tpNode.next = newNode
            
        }
        return node
    }
// Time complexity: O(n + 1) = O(n)
    // Space : O(9) + O(n)
    func solutionII(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let result = ListNode(0)
        var carry = 0
        var l1 = l1, l2 = l2
        var l3: ListNode? = result

        while(l1 != nil || l2 != nil) {
            let sum = (l1?.val ?? 0) + (l2?.val ?? 0) + carry
            carry = sum/10
            l3?.val = sum % 10
            if l1?.next != nil || l2?.next != nil || carry > 0 {
                l3?.next =  ListNode(0)
                l3 = l3?.next
            }
            l1 = l1?.next
            l2 = l2?.next
           
        }
        if carry > 0 {
            l3?.val = carry
            
        }
        return result
    }
}
