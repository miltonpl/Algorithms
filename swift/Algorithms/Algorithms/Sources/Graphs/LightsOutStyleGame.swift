//
//  LightsOutStyleGame.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 4/19/23.
//
/**
 ```Challange```
 
    - You have been tasked with building a Lights Out-style game. The game should do the following:
    - Display a grid with X columns and Y rows.
    - Each cell should start randomly with either blue or yellow color.
    - When you tap a yellow cell, it should change all adjacent (top, left, bottom, right) yellow cells to blue cells.
    - Each cell that was changed should also change their yellow colored neighboring cells to blue, and so on. (Like a paint bucket tool)
    - When you tap a blue cell, it will do the same as above, except with blue cells.
    - When all cells have changed to a single color, display a win message.
*/
import Foundation
// Folow BSF Algorithem approuch
// Note: works great but it need improment

class LightsOutStyleGame {
    struct Point {
        var changed: Bool
        let x: Int
        let y: Int
    }

    struct Queue {
        private var points = [Point]()

        var isEmpty: Bool {
            points.isEmpty
        }
        
        mutating func enqueue(_ point: Point) {
            points.append(point)
        }

        mutating func dequeue() -> Point? {
            return isEmpty ? nil : points.removeFirst()
        }
    }

    func grid(x: Int, y: Int, tappedX: Int, tappedY: Int) {
        guard tappedX >= 0, tappedX < x, tappedY < y, tappedY >= 0, x > 0, y > 0 else { return }
        let yellow = "y"
        let blue = "b"
        let colors = [yellow, blue]
        var box = [[String]]()
        var visited = [[Bool]]()
        for _ in 0..<y {
            var row = [Bool]()
            for _ in 0..<x {
                row.append(false)
            }
            visited.append(row)
        }
        visited[tappedY][tappedX] = true

       for _ in 0..<y {
           var row = [String]()
           for _ in 0..<x {
               row.append(colors.randomElement()!)
           }
           box.append(row)
       }

        let tappedCell = box[tappedY][tappedX]
        let top = tappedY + 1
        let bottom = tappedY - 1
        let left = tappedX - 1
        let right = tappedX + 1
        var queue = Queue()

        if tappedCell == yellow {
            if top < y {
                box[tappedX][top] = blue
                visited[tappedX][top] = true
                queue.enqueue(.init(changed: true, x: tappedX, y: top))
            }
            if bottom >= 0 {
                box[tappedX][bottom] = blue
                visited[tappedX][bottom] = true
                queue.enqueue(.init(changed: true, x: tappedX, y: bottom))
            }
            if right < x {
                box[right][tappedY] = blue
                visited[right][tappedY] = true
                queue.enqueue(.init(changed: true, x: right, y: tappedY))
            }
            if left >= 0 {
                box[left][tappedY] = blue
                visited[left][tappedY] = true
                queue.enqueue(.init(changed: true, x: left, y: tappedY))
            }
        } else {
            if top < y {
                visited[tappedX][top] = true
                queue.enqueue(.init(changed: true, x: tappedX, y: top))
            }
            if bottom >= 0 {
                visited[tappedX][bottom] = true
                queue.enqueue(.init(changed: true, x: tappedX, y: bottom))
            }
            if right < x {
                visited[right][tappedY] = true
                queue.enqueue(.init(changed: true, x: right, y: tappedY))
            }
            if left >= 0 {
                visited[left][tappedY] = true
                queue.enqueue(.init(changed: true, x: left, y: tappedY))
            }
        }

        while let p = queue.dequeue() {
            let currentCell = box[p.x][p.y]
            var neighbors = [Point]()
            let top = p.y + 1
            let bottom = p.y - 1
            let left = p.x - 1
            let right = p.x + 1
            // four neighbors
            if top < y && top >= 0 && p.x >= 0 && p.x < x {
                neighbors.append(.init(changed: false, x: p.x, y: top))
            }
            if bottom < y && bottom >= 0 && p.x >= 0 && p.x < x {
                neighbors.append(.init(changed: false, x: p.x, y: bottom))
            }
            if right < x && right >= 0 && p.y < y && p.y >= 0 {
                neighbors.append(.init(changed: false, x: right, y: p.y))
            }
            if left < x && left >= 0 && p.y < y && p.y >= 0 {
                neighbors.append(.init(changed: false, x: left, y: p.y))
            }
            
            for neighbor in neighbors {
                var currenNeibeor = neighbor
                if visited[neighbor.x][neighbor.y] == false {
                    visited[neighbor.x][neighbor.y] = true
                    
                    if box[neighbor.x][neighbor.y] == yellow
                        && currentCell == yellow
                        && p.changed == true {
                        box[neighbor.x][neighbor.y] = blue
                        currenNeibeor.changed = true
                    } else if box[neighbor.x][neighbor.y] == blue
                                && currentCell == blue
                                && tappedCell != blue
                                && p.changed == true {
                        box[neighbor.x][neighbor.y] = yellow
                        currenNeibeor.changed = true
                    }
                    queue.enqueue(currenNeibeor)
                }
            }
        }
        // Check winner
        var isWinner = true
        for j in 0..<y {
            for i in 0..<x {
                if box[j][i] != tappedCell {
                    isWinner = false
                    break
                }
            }
        }

        if isWinner {
            print("Congrats, we hava a winner!!")
            dispay(box: box)
        }
    }

    func neighbors(point p: Point, bounds: Point) -> [Point] {
        guard p.x >= 0 && p.y >= 0 && p.x < bounds.x && p.y <  bounds.y else { fatalError("point not in bound") }
        var neighbors = [Point]()
        let top = p.y + 1
        let bottom = p.y - 1
        let left = p.x - 1
        let right = p.x + 1
        if top < bounds.y {
            neighbors.append(.init(changed: false, x: p.x, y: top))
        }
        if bottom >= 0 {
            neighbors.append(.init(changed: false, x: p.x, y: bottom))
        }
        if right <  bounds.x {
            neighbors.append(.init(changed: false, x: right, y: p.y))
        }
        if left >= 0 {
            neighbors.append(.init(changed: false, x: left, y: p.y))
        }
        return neighbors
    }

    private func dispay(box: [[String]]) {
        print("-------------------------")
        for row in box {
            for col in row {
                print(col, terminator: " ")
            }
            print("")
        }
    }

    private func dispay(visited: [[Bool]]) {
        print("-------------------------")
        for row in visited {
            for col in row {
                print(col ? 1 : 0, terminator: " ")
            }
            print("")
        }
    }
}
