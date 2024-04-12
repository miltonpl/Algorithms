//
//  LengthOfLongestSubstring.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/4/24.
//

import Foundation
/*
 Given a string s, find the length of the longest `substring` without repeating characters.

 Example 1:

 Input: s = "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.
 Example 2:

 Input: s = "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.
 Example 3:

 Input: s = "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.
 Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
  

 Constraints:

 0 <= s.length <= 5 * 104
 s consists of English letters, digits, symbols and spaces.
 
 */
/**
 s = "abcabcbb"
 (key-> value)
 a:0->3
 b:1->4->6->7
 c:2->5
 
 R1
 key=a
 Index = 3
 startIndex=1
 longest=3 // abc
 
 R2
 key=b
 index=4
 foundIndex=1
 startIndex=2
 longest= max(3,  4 - 2 + 1) 3 // bca
 
 R3
 key=c
 index5
 foundIndex=2
 startIndex= max(2 + 1, 2) = 3
 longest=(3, 5 - 3 + 1)= 3
 */
/*
 Test 2.
 s= "pwwkew"
 key,val
 p:0
 w:1->2->5
 k:3
 e:4
 
 R1
 index=0, char="p"
 longest 1
 
 R2
 index=1 char="w"
 longest =(1,2) = 2
 
 R3
 index=2,char="w"
 startIndex=max(2,0) = 2
 longest=(2,2-2+1) = 2
 
 R4
 index=3, char="k"
 longest=max(2, 3-2+1) = 2
 
 R5
 index=4, char = "e"
 longest = max(2,4-2+1)=3
 
 R6
 index=5,char="w"
 startIndex=max(2 + 1, 2)=3
 longest = max(3,5 - 3 + 1)=3
 */
class LengthOfLongestSubstring {
    func solution(_ s: String) -> Int {
        var longest = 0
        var startIndex = 0
        var charMap = [Character: Int]()
        
        for (index, char) in s.enumerated() {
            if let foundIndex = charMap[char] {
                startIndex = max(foundIndex + 1, startIndex)
            }
            longest = max(longest, index - startIndex + 1)
            charMap[char] = index
        }
        return longest
    }
}
