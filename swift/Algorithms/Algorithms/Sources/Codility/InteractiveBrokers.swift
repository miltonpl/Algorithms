//
//  InteractiveBrokers.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/26/23.
//

import Foundation

// Task 1
/*
 You are geven a string representing a sequence of N arrows, each pointing in one of the four cardinal directional up(^), down(v), left(<), right(>)
 Write a function solution that given a string S denoing the directions of the arrows,
return the mininum number of arrows that must be rotated to make them all point to the same direction.
 1. Given "<^^v", the function should return 2.
 after rotating both the first "^" and the fourth "v" arrows downwards "v",
 all of the arrow would be point downwards
 
 2. Given S = "v>>>vv", the function should return 3. After rotating the first,
 fifth and sixth arrow rightwards, all of the arrows would point right.
 
 3. Given S = "<<<" the function should return 0. All of the arrows already
 point left.
 Assume that:
 */
class InteractiveBrokers {
    public func solution2(_ S: String) -> Int {
        var dic = [Character: Int]()
        for char in S {
            if var value = dic[char] {
                value += 1
                dic[char] = value
            } else {
                dic[char] = 1
            }
        }
        var maxValue = 0
        var maxKey: Character = "x"
        for (key, value) in dic {
            if value > maxValue {
                maxValue = value
                maxKey = key
            }
        }
        dic.removeValue(forKey: maxKey)
        return dic.reduce(0, { $0 + $1.value })
    }

    public func solution(_ S: String) -> Int {
        var dic = [Character: Int]()
        for char in S {
            if var value = dic[char] {
                value += 1
                dic[char] = value
            } else {
                dic[char] = 1
            }
        }
        var maxValue = 0
        var maxKey: Character = "x"
        for (key, value) in dic {
            if value > maxValue {
                maxValue = value
                maxKey = key
            }
        }
        if maxKey != "x" {
            dic.removeValue(forKey: maxKey)
        }
        var total = 0
        for (_, value) in dic {
            total += value
        }
        if maxValue >= S.count {
            return 0
        } else {
            return total
        }
    }
}

// Task2
protocol WorkItemProvider {
    func workItem(actionBlock: @escaping () -> ()) -> DispatchWorkItem?
}

class DefaultWorkItemProvider: WorkItemProvider {
    func workItem(actionBlock: @escaping () -> ()) -> DispatchWorkItem? {
        return DispatchWorkItem(block: actionBlock)
    }
}

class SessionWatcher {
    private var workItemProvider: WorkItemProvider
    private var workItem: DispatchWorkItem?
    private let sessionTime: TimeInterval
    private let queue: DispatchQueue

    var onTimeExceeded: (() -> Void)?

    init(sessionTime: TimeInterval = 5, workItemProvider: WorkItemProvider, queue: DispatchQueue) {
        self.workItemProvider = workItemProvider
        self.sessionTime = sessionTime
        self.queue = queue
    }

    func start() {
        workItem?.cancel()
        workItem = workItemProvider.workItem(actionBlock: {
            // Do some work
        })
        guard let workItem = workItem else { return }

        let deadline: DispatchTime = .now() + .seconds(Int(sessionTime))
        queue.asyncAfter(deadline: deadline, execute: workItem)
    }

    func receivedUserAction() {
        guard let workItem = workItem else { return }
        queue.async(execute: workItem)
    }

    func stop() {
        workItem?.cancel()
    }
}
