//
//  MergeIntervals.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/10/24.
//

import Foundation
typealias Interval = (start: Int, end: Int)

struct MergeIntervals {
    func mySolution(intervals: [[Int]]) -> [[Int]] {
        let intervalstp = intervals.sorted { $0.first! < $1.first!}
        var intervals = [Interval]()
        for interval in intervalstp {
            intervals.append((start: interval[0], end: interval[1]))
        }
        var result = [Interval]()

        for interval in intervals {
            if let index = result.firstIndex(where: { $0.end >= interval.start}) {
                let start = min(result[index].start, interval.start)
                let end = max(result[index].end, interval.end)
                result[index] = Interval(start: start, end: end)
            } else {
                result.append(interval)
            }
        }
        return result.map { [$0.start, $0.end]}
    }

    func solution(intervals: [[Int]]) -> [[Int]] {
        if intervals.isEmpty { return [[Int]]() }

        let sortedIntervals = intervals.sorted{ $0[0] < $1[0] }

        var s1 = sortedIntervals[0][0]
        var e1 = sortedIntervals[0][1]
        var res = [[Int]]()

        for interval in sortedIntervals {
            let s = interval[0]
            let e = interval[1]

            if e1 >= s {
                e1 = max(e, e1)
            } else {
                res.append([s1, e1])
                s1 = s
                e1 = e
            }
        }

        res.append([s1, e1])
        return res
    }
}
