//
//  GameModel.swift
//  twentyFortyEight
//
//  Created by Александра on 01.04.2025.
//

import Foundation

enum Direction {
    case up, down, left, right
}

class GameModel: ObservableObject {
    @Published var board: [[Int]]
    @Published var score: Int = 0
    @Published var bestScore: Int = 0
    @Published var isGameOver: Bool = false
    @Published var hasWon: Bool = false
    @Published var is2048: Int = 0
    
    private let boardSize = 4
    private let bestScoreKey = "bestScore"
    
    init() {
        board = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        loadBestScore()
        startNewGame()
    }
    
    private func loadBestScore() {
        bestScore = UserDefaults.standard.integer(forKey: bestScoreKey)
    }
    
    private func saveBestScore() {
        if score > bestScore {
            bestScore = score
            UserDefaults.standard.set(bestScore, forKey: bestScoreKey)
        }
    }
    
    func startNewGame() {
        board = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        score = 0
        isGameOver = false
        hasWon = false
        addNewTile()
        addNewTile()
    }
    
    func move(_ direction: Direction) {
        let oldBoard = board
        var moved = false
        
        switch direction {
        case .left:
            moved = moveLeft()
        case .right:
            moved = moveRight()
        case .up:
            moved = moveUp()
        case .down:
            moved = moveDown()
        }
        
        if moved {
            addNewTile()
            checkGameState()
            saveBestScore()
        }
    }
    
    private func moveLeft() -> Bool {
        var moved = false
        for row in 0..<boardSize {
            var line = board[row].filter { $0 != 0 }
            var i = 0
            while i < line.count - 1 {
                if line[i] == line[i + 1] {
                    line[i] *= 2
                    score += line[i]
                    line.remove(at: i + 1)
                    moved = true
                } else {
                    i += 1
                }
            }
            let newLine = line + Array(repeating: 0, count: boardSize - line.count)
            if newLine != board[row] {
                moved = true
            }
            board[row] = newLine
        }
        return moved
    }
    
    private func moveRight() -> Bool {
        var moved = false
        for row in 0..<boardSize {
            var line = board[row].filter { $0 != 0 }
            var i = line.count - 1
            while i > 0 {
                if line[i] == line[i - 1] {
                    line[i] *= 2
                    score += line[i]
                    line.remove(at: i - 1)
                    i -= 1
                    moved = true
                } else {
                    i -= 1
                }
            }
            let newLine = Array(repeating: 0, count: boardSize - line.count) + line
            if newLine != board[row] {
                moved = true
            }
            board[row] = newLine
        }
        return moved
    }
    
    private func moveUp() -> Bool {
        var moved = false
        for col in 0..<boardSize {
            var line = board.map { $0[col] }.filter { $0 != 0 }
            var i = 0
            while i < line.count - 1 {
                if line[i] == line[i + 1] {
                    line[i] *= 2
                    score += line[i]
                    line.remove(at: i + 1)
                    moved = true
                } else {
                    i += 1
                }
            }
            let newLine = line + Array(repeating: 0, count: boardSize - line.count)
            for row in 0..<boardSize {
                if board[row][col] != newLine[row] {
                    moved = true
                }
                board[row][col] = newLine[row]
            }
        }
        return moved
    }
    
    private func moveDown() -> Bool {
        var moved = false
        for col in 0..<boardSize {
            var line = board.map { $0[col] }.filter { $0 != 0 }
            var i = line.count - 1
            while i > 0 {
                if line[i] == line[i - 1] {
                    line[i] *= 2
                    score += line[i]
                    line.remove(at: i - 1)
                    i -= 1
                    moved = true
                } else {
                    i -= 1
                }
            }
            let newLine = Array(repeating: 0, count: boardSize - line.count) + line
            for row in 0..<boardSize {
                if board[row][col] != newLine[row] {
                    moved = true
                }
                board[row][col] = newLine[row]
            }
        }
        return moved
    }
    
    private func addNewTile() {
        var availablePositions: [(Int, Int)] = []
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                if board[i][j] == 0 {
                    availablePositions.append((i, j))
                }
            }
        }
        
        if let randomPosition = availablePositions.randomElement() {
            board[randomPosition.0][randomPosition.1] = Bool.random() ? 2 : 4
        }
    }
    
    private func checkGameState() {
        for row in board {
            if row.contains(2048) && is2048 == 0 {
                hasWon = true
                is2048 = 1
                return
            }
        }

        var hasEmptyCell = false
        for row in board {
            if row.contains(0) {
                hasEmptyCell = true
                break
            }
        }
        
        if !hasEmptyCell {
            for i in 0..<boardSize {
                for j in 0..<boardSize {
                    let current = board[i][j]
                    if (j < boardSize - 1 && current == board[i][j + 1]) ||
                       (i < boardSize - 1 && current == board[i + 1][j]) {
                        return
                    }
                }
            }
            isGameOver = true
        }
    }
} 
