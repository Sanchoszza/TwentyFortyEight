//
//  GameBoardView.swift
//  twentyFortyEight
//
//  Created by Александра on 01.04.2025.
//

import SwiftUI

struct GameBoardView: View {
    @StateObject private var gameModel = GameModel()
    @State private var boardSize: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Best Score")
                            .font(.headline)
                        Text("\(gameModel.bestScore)")
                            .font(.title)
                            .bold()
                    }
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Score")
                            .font(.headline)
                        Text("\(gameModel.score)")
                            .font(.title)
                            .bold()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        gameModel.startNewGame()
                    }) {
                        Text("New Game")
                            .font(.headline)
                            .foregroundColor(Color.theme.colorTextWhite)
                            .padding()
                            .background(Color.theme.colorButtonBg)
                            .cornerRadius(8)
                    }
                }

                VStack(spacing: 8) {
                    ForEach(0..<4) { row in
                        HStack(spacing: 8) {
                            ForEach(0..<4) { col in
                                TileView(value: gameModel.board[row][col])
                                    .frame(width: max(0, boardSize / 4 - 10), height: max(0, boardSize / 4 - 10))
                            }
                        }
                    }
                }
                .padding(8)
//                .background(Color(.systemGray6))
                .background(Color.theme.backgroundGameFrame)
                .cornerRadius(8)
                .gesture(
                    DragGesture(minimumDistance: 10)
                        .onEnded { gesture in
                            let horizontal = abs(gesture.translation.width)
                            let vertical = abs(gesture.translation.height)
                            
                            if horizontal > vertical {
                                if gesture.translation.width > 0 {
                                    gameModel.move(.right)
                                } else {
                                    gameModel.move(.left)
                                }
                            } else {
                                if gesture.translation.height > 0 {
                                    gameModel.move(.down)
                                } else {
                                    gameModel.move(.up)
                                }
                            }
                        }
                )
                
                Spacer()
            }
            .padding()
            .onAppear {
                let size = min(geometry.size.width, geometry.size.height) - 40
                boardSize = max(0, size)
            }
            .alert("Game Over!", isPresented: $gameModel.isGameOver) {
                Button("New Game") {
                    gameModel.startNewGame()
                }
            } message: {
                Text("Your score: \(gameModel.score)")
            }
            .alert("Congratulations!", isPresented: $gameModel.hasWon) {
                Button("Continue Playing") {
                    gameModel.hasWon = false
                }
            } message: {
                Text("You've reached 2048! Keep going!")
            }
        }
    }
}

#Preview {
    GameBoardView()
} 
