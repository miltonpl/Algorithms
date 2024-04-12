//
//  MindMedianSortedArrays.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/5/24.
//

import Foundation
/*
 Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.

 The overall run time complexity should be O(log (m+n)).

  

 Example 1:

 Input: nums1 = [1,3], nums2 = [2]
 Output: 2.00000
 Explanation: merged array = [1,2,3] and median is 2.
 Example 2:

 Input: nums1 = [1,2], nums2 = [3,4]
 Output: 2.50000
 Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
 Example: 2
 nums1 = [3,6,8] nums2 = [4,7,9]
 nums = [3,4,6,7,8,9]
 medim = (6 + 7)/2 = 6.5
 */
class FindMedianSortedArrays {
    func solution(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var nums = nums1
        
        nums.append(contentsOf: nums2)
        let medium = nums.count/2
        let arr = Array(nums.sorted())
        if (nums.count % 2) == 0 {
            return Double(arr[medium  - 1] + arr[medium])/2.0

        } else {
            return Double(arr[medium])
        }
    }

    func solutions2(_ nums1: [Int], _ nums2: [Int]) -> Double {
          // Make sure nums1 is the shorter array
          let a = nums1.count <= nums2.count ? nums1 : nums2
          let b = nums1.count <= nums2.count ? nums2 : nums1

          var start = 0
          var end = a.count
          let totalLength = a.count + b.count
          let halfLength = (totalLength + 1) / 2

          while start <= end {
              let i = (start + end) / 2
              let j = halfLength - i
              
              let aLeft = i > 0 ? a[i - 1] : Int.min
              let aRight = i < a.count ? a[i] : Int.max
              let bLeft = j > 0 ? b[j - 1] : Int.min
              let bRight = j < b.count ? b[j] : Int.max

              if aLeft <= bRight && bLeft <= aRight {
                  // Correct partition found
                  if totalLength % 2 == 0 {
                      return Double(max(aLeft, bLeft) + min(aRight, bRight)) / 2.0
                  } else {
                      return Double(max(aLeft, bLeft))
                  }
              } else if aLeft > bRight {
                  end = i - 1
              } else {
                  start = i + 1
              }
          }
          
          // Should not reach here
          return -1.0
      }
}
/*
 The key thing to solve this problem is to break it down and conceptualize the problem in terms of space available.

 Sub-problem 1:

 space availabe between 2 seats and given K, how many tables can be occupied?
 => Answer - (space-k)/(k+1) and this numbers can be arrived by trying couple examples with based values to higher values.
 Sub-problem 2:
 Convert edge cases of front and end table occupancy which can be generalized with occupying first and last table then this problem is reduced to the sub-problem (1)
 import java.util.Arrays;

 public class Occupy {

 public static void main(String[] args) {
     int[] occupied = {11, 6, 14};
     int n = 15;
     int k = 2;
     System.out.println(solve(occupied, n, k));
 }

 static int solve(int[] occupied, int n, int k) {
     int ans = 0;
     if(occupied.length == 0) {
         return n/(k+1);
     }
     Arrays.sort(occupied);
     int spaceAvailable = occupied[0]-2;
     if(spaceAvailable >= 2*k+1)
         ans +=(spaceAvailable-k)/(k+1);
     if(occupied[0] > k+1)
         ans += 1;

     for(int i = 1; i < occupied.length; i++) {
         spaceAvailable = (occupied[i]-occupied[i-1]-1);
         if(spaceAvailable >= 2*k+1) {
             ans += (spaceAvailable-k)/(k+1);
         }
         System.out.println(ans +"  "+occupied[i]);
     }
     if(occupied[occupied.length-1] < n-k) ans += 1;
     spaceAvailable = n-occupied[occupied.length-1]-1;
     if(spaceAvailable >= 2*k+1) {
         ans += (spaceAvailable-k)/(k+1);
     }
     return ans;
 }
 }
 
 
 It passes one test case but fails second one, please let me know what I'm doing wrong!!
 Passes:
 N = 15
 K = 2
 M = 3
 S = [11, 6, 14]
 return 1
 Fails:
 N = 10
 K = 1
 M = 2
 S = [2, 6]
 return 3
 
 */
