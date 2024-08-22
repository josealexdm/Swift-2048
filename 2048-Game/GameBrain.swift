//
//  GameBrain.swift
//  2048
//
//  Created by Jose Alexandre de Moraes on 6/17/24.
//

import Foundation

struct GameBrain {
    var gameArray = [["", "", "", ""], ["", "", "", ""], ["", "", "", ""], ["", "", "", ""]]
    var pointerArray = [0, 0, 0, 0]
    var score = 0
    
    mutating func startNewGame() {
        gameArray = [["", "", "", ""], ["", "", "", ""], ["", "", "", ""], ["", "", "", ""]]
        //gameArray = [["2", "", "", ""], ["", "0", "", ""], ["", "", "4", ""], ["", "", "", "8"]]
        //gameArray = [["", "", "", ""], ["2", "0", "4", "8"], ["", "", "", ""], ["", "", "", ""]]
        score = 0
        var count = 0
        var row = 0
        var col = 0
        repeat {
            row = Int.random(in: 0...3)
            col = Int.random(in: 0...3)
            if gameArray[row][col] == "" {
                gameArray[row][col] = "2"
                count += 1
            }
        } while count < 2
    }

    mutating func continueGame() {
        var count = 0
        var maxCount = 0
        var row = 0
        var col = 0
        repeat {
            row = Int.random(in: 0...3)
            col = Int.random(in: 0...3)
            if gameArray[row][col] == "" {
                gameArray[row][col] = "2"
                count += 1
            }
            // use maxCount to avoid infinite loop
            maxCount += 1
            //print("passou:\(maxCount)")
        } while count < 1 && maxCount < 100
    }

    func checkGameOver() -> Bool {
        for row in 0...3 {
            for col in 0...3 {
                if gameArray[row][col] == "" {
                    // return false while there is at least one empty position
                    return false
                }
                if row < 3 && col < 3 {
                    // return false while there is at least one pair of values to be summarized
                    if gameArray[row][col] == gameArray[row][col + 1] || gameArray[row][col] == gameArray[row + 1][col] {
                        return false
                    }
                }
                if row == 3 && col < 3 {
                    // return false while there is at least one pair of values to be summarized
                    if gameArray[row][col] == gameArray[row][col + 1] {
                        return false
                    }
                }
                if row < 3 && col == 3 {
                    // return false while there is at least one pair of values to be summarized
                    if gameArray[row][col] == gameArray[row + 1][col] {
                        return false
                    }
                }
            }
        }
        return true
    }
  
    mutating func moveRight() {
        var pointer = 0
        var col = 0
        var cellValue = 0
        for row in 0...3 {
            pointer = pointerArray[row]
            //print(pointer)
            if gameArray[row][pointer] == "" {
                // Shift right when position is empty
                col = pointer
                while col > 0 {
                    gameArray[row][col] = gameArray[row][col - 1]
                    col -= 1
                }
                gameArray[row][0] = ""
            } else {
                if gameArray[row][pointer] == gameArray[row][pointer - 1] {
                    // Sum and shift other columns when columns have same value
                    cellValue = Int(gameArray[row][pointer])! * 2
                    score += cellValue
                    gameArray[row][pointer] = "\(cellValue)"
                    col = pointer - 1
                    while col > 0 {
                        //print("col:\(col)")
                        gameArray[row][col] = gameArray[row][col - 1]
                        col -= 1
                    }
                    gameArray[row][0] = ""
                    pointerArray[row] -= 1
                } else if gameArray[row][pointer - 1] == "" {
                    // Shift other columns when position at left side of pointer is empty
                    col = pointer - 1
                    while col > 0 {
                        gameArray[row][col] = gameArray[row][col - 1]
                        col -= 1
                    }
                    gameArray[row][0] = ""
                } else {
                    // Both columns are not empty but with different values, so only pointer need to be updated
                    pointerArray[row] -= 1
                }
            }
        }
    }
    
    mutating func moveLeft() {
        var pointer = 0
        var col = 0
        var cellValue = 0
        for row in 0...3 {
            pointer = pointerArray[row]
            //print(pointer)
            if gameArray[row][pointer] == "" {
                // Shift left when position is empty
                col = pointer
                while col < 3 {
                    gameArray[row][col] = gameArray[row][col + 1]
                    col += 1
                }
                gameArray[row][3] = ""
            } else {
                if gameArray[row][pointer] == gameArray[row][pointer + 1] {
                    // Sum and shift other columns when columns have same value
                    cellValue = Int(gameArray[row][pointer])! * 2
                    score += cellValue
                    gameArray[row][pointer] = "\(cellValue)"
                    col = pointer + 1
                    while col < 3 {
                        //print("col:\(col)")
                        gameArray[row][col] = gameArray[row][col + 1]
                        col += 1
                    }
                    gameArray[row][3] = ""
                    pointerArray[row] += 1
                } else if gameArray[row][pointer + 1] == "" {
                    // Shift other columns when position at right side of pointer is empty
                    col = pointer + 1
                    while col < 3 {
                        gameArray[row][col] = gameArray[row][col + 1]
                        col += 1
                    }
                    gameArray[row][3] = ""
                } else {
                    // Both columns are not empty but with different values, so only pointer need to be updated
                    pointerArray[row] += 1
                }
            }
        }
    }
    
    mutating func moveDown() {
        var pointer = 0
        var row = 0
        var cellValue = 0
        for col in 0...3 {
            pointer = pointerArray[col]
            //print(pointer)
            if gameArray[pointer][col] == "" {
                // Shift right when position is empty
                row = pointer
                while row > 0 {
                    gameArray[row][col] = gameArray[row - 1][col]
                    row -= 1
                }
                gameArray[0][col] = ""
            } else {
                if gameArray[pointer][col] == gameArray[pointer - 1][col] {
                    // Sum and shift other columns when columns have same value
                    cellValue = Int(gameArray[pointer][col])! * 2
                    score += cellValue
                    gameArray[pointer][col] = "\(cellValue)"
                    row = pointer - 1
                    while row > 0 {
                        //print("col:\(col)")
                        gameArray[row][col] = gameArray[row - 1][col]
                        row -= 1
                    }
                    gameArray[0][col] = ""
                    pointerArray[col] -= 1
                } else if gameArray[pointer - 1][col] == "" {
                    // Shift other columns when position at left side of pointer is empty
                    row = pointer - 1
                    while row > 0 {
                        gameArray[row][col] = gameArray[row - 1][col]
                        row -= 1
                    }
                    gameArray[0][col] = ""
                } else {
                    // Both columns are not empty but with different values, so only pointer need to be updated
                    pointerArray[col] -= 1
                }
            }
        }
    }
    
    mutating func moveUp() {
        var pointer = 0
        var row = 0
        var cellValue = 0
        for col in 0...3 {
            pointer = pointerArray[col]
            //print(pointer)
            if gameArray[pointer][col] == "" {
                // Shift left when position is empty
                row = pointer
                while row < 3 {
                    gameArray[row][col] = gameArray[row + 1][col]
                    row += 1
                }
                gameArray[3][col] = ""
            } else {
                if gameArray[pointer][col] == gameArray[pointer + 1][col] {
                    // Sum and shift other columns when columns have same value
                    cellValue = Int(gameArray[pointer][col])! * 2
                    score += cellValue
                    gameArray[pointer][col] = "\(cellValue)"
                    row = pointer + 1
                    while row < 3 {
                        //print("col:\(col)")
                        gameArray[row][col] = gameArray[row + 1][col]
                        row += 1
                    }
                    gameArray[3][col] = ""
                    pointerArray[col] += 1
                } else if gameArray[pointer + 1][col] == "" {
                    // Shift other columns when position at right side of pointer is empty
                    row = pointer + 1
                    while row < 3 {
                        gameArray[row][col] = gameArray[row + 1][col]
                        row += 1
                    }
                    gameArray[3][col] = ""
                } else {
                    // Both columns are not empty but with different values, so only pointer need to be updated
                    pointerArray[col] += 1
                }
            }
        }
    }

}
