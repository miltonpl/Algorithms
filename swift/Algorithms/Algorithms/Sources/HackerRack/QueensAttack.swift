//
//  QueensAttack.swift
//  Algorithms
//
//  Created by Milton Palaguachi on 9/28/23.
//

import Foundation
/*
 You will be given a square chess board with one queen and a number of obstacles placed on it. Determine how many squares the queen can attack.
A queen is standing on an  chessboard. The chess board's rows are numbered from  to , going from bottom to top. Its columns are numbered from  to , going from left to right. Each square is referenced by a tuple, , describing the row, , and column, , where the square is located.
The queen is standing at position . In a single move, she can attack any square in any of the eight directions (left, right, up, down, and the four diagonals). In the diagram below, the green circles denote all the cells the queen can attack from :*/
/*
 * Complete the 'queensAttack' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts following parameters:
 *  1. INTEGER n
 *  2. INTEGER k
 *  3. INTEGER r_q
 *  4. INTEGER c_q
 *  5. 2D_INTEGER_ARRAY obstacles
 */
struct Box: Hashable {
    let x,y: Int
}

func queensAttack(n: Int, k: Int, r_q: Int, c_q: Int, obstacles: [[Int]]) -> Int {
   
    var obstacleSet: Set<Box> = []

    for row in obstacles {
        let x = row[0]
        let y = row[1]
        obstacleSet.insert(.init(x: x, y: y))
    }

    let upper = n + 1
    let lower = 0
    var result = 0

    var left = r_q - 1
    var right = r_q + 1
    // horizontal line
    while right < upper || left > lower {
        if right < upper {
            if obstacleSet.contains(.init(x: right, y: c_q)) {
                right = upper
            } else {
                result += 1
                right += 1
            }
        }

        if left > lower {
            if obstacleSet.contains(.init(x: left, y: c_q)) {
                left = lower
            } else {
                result += 1
                left -= 1
            }
        }
    }
    var up = c_q + 1
    var down = c_q - 1

    // diaganol from bottom left to uppper right
    while up < upper || down > lower {
        if up < upper {
            if obstacleSet.contains(.init(x: up, y: up)) {
                up = upper
            } else {
                result += 1
                up += 1
            }
        }

        if down > lower {
            if obstacleSet.contains(.init(x: down, y: down)) {
                down = lower
            } else {
                result += 1
                down -= 1
            }
        }
    }
    up = c_q + 1
    down = r_q - 1
    right = r_q + 1
    left = c_q - 1
    // diagonal from upper left side to lower right side
    while up < upper && down > lower || right < upper && left > lower {
        if up < upper && down > lower  {
            if obstacleSet.contains(.init(x: down, y: up)) {
                up = upper
                down = lower
            } else {
                result += 1
                up += 1
                down -= 1
            }
        }

        if right < upper && left > lower {
            if obstacleSet.contains(.init(x: right, y: left)) {
                right = upper
                left = lower
            } else {
                result += 1
                left -= 1
                right += 1
            }
        }
    }
    
    
    down = c_q - 1
    up = c_q + 1
    // vertical line
    while up < upper || down > lower {
        if up < upper {
            if obstacleSet.contains(.init(x: r_q, y: up)) {
                up = upper
            } else {
                result += 1
                up += 1
            }
        }

        if down > lower {
            if obstacleSet.contains(.init(x: r_q, y: down)) {
                down = lower
            } else {
                result += 1
                down -= 1
            }
        }
    }

    return result
}
