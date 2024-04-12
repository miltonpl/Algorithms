//
//  TimeConversion.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 9/28/23.
//

import Foundation
/*
 Given a time in -hour AM/PM format, convert it to military (24-hour) time.
 Note: - 12:00:00AM on a 12-hour clock is 00:00:00 on a 24-hour clock.
 - 12:00:00PM on a 12-hour clock is 12:00:00 on a 24-hour clock.
 Example
s = "12:01:00PM"
 Return '12:01:00'.
- s = "12:01:00AM"
 Return '00:01:00'.
 Function Description
 Complete the timeConversion function in the editor below. It should return a new string representing the input time in 24 hour format.
 timeConversion has the following parameter(s):
 string s: a time in  hour format
 Returns
 string: the time in  hour format
 Input Format
 A single string  that represents a time in -hour clock format (i.e.:  or ).
 
 */
/*
 * Complete the 'timeConversion' function below.
 *
 * The function is expected to return a STRING.
 * The function accepts STRING s as parameter.
 */
// 12Hour AM/PM - 24Hour
/*
1 - 1
12 - 12
1 PM 13
7 pm - 19:00
*/
func timeConversion(s: String) -> String {
    // Write your code here
    var tmp = s
    tmp.removeLast()
    tmp.removeLast()
    var array = tmp.split(separator: ":")
    let hour = Int(array.first ?? "") ?? 0

    guard s.contains("PM") else {
        if hour == 12 {
            array.removeFirst()
            return "00:" + array.joined(separator: ":")
        }
        return tmp
    }
    guard hour < 12 else {
        return tmp
    }
    array.removeFirst()
    return "\(hour + 12):" + array.joined(separator: ":")
}
