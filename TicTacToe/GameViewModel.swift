//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Prakash Bist on 04/05/2021.
//

import SwiftUI

final class GameViewModel: ObservableObject{
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isBoardDisabled: Bool = false
    @Published var alertItem: AlertItem?
    private var player1Turn: Bool = true
    @Published var singleModeOn: Bool = false
    @Published var normalLevelOn: Bool = false
    
    func fetchGameSettings(){
        let single = UserDefaults.standard.bool(forKey: "singleMode")
        singleModeOn = single ? true : false
        let normal = UserDefaults.standard.bool(forKey: "normalLevel")
        normalLevelOn = normal ? true : false
        
    }
    
    func processPlayerMove(for position: Int){
        
        if singleModeOn{
            if isSquareOccupied(in: moves, forIndex: position) { return }
            moves[position] = Move(player: .human, boardIndex: position)
            
            if checkWinCondition(for: .human, in: moves) {
                alertItem = singleModeOn ? AlertContext.humanWin : AlertContext.Player1Win
                return
            }
            if checkForDraw(in: moves){
                alertItem = AlertContext.draw
                return
            }
            isBoardDisabled = true
            //computer moves
            DispatchQueue.main.asyncAfter(deadline: .now()+1){ [self] in
                let computerPosition = determineComputerMovePosition(in: moves)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                isBoardDisabled = false
                
                if checkWinCondition(for: .computer, in: moves) {
                    alertItem = AlertContext.computerWin
                    return
                }
                if checkForDraw(in: moves){
                    alertItem = AlertContext.draw
                    return
                }
            }
        }else{
            player1Turn = UserDefaults.standard.bool(forKey: "player1turn")
            if player1Turn{
                //human moves
                UserDefaults.standard.setValue(false, forKey: "player1turn")
                if isSquareOccupied(in: moves, forIndex: position) { return }
                moves[position] = Move(player: .human, boardIndex: position)
                
                if checkWinCondition(for: .human, in: moves) {
                    alertItem = singleModeOn ? AlertContext.humanWin : AlertContext.Player1Win
                    return
                }
                if checkForDraw(in: moves){
                    alertItem = AlertContext.draw
                    return
                }
            }
            if !player1Turn {
                UserDefaults.standard.setValue(true, forKey: "player1turn")
                if isSquareOccupied(in: moves, forIndex: position) { return }
                moves[position] = Move(player: .computer, boardIndex: position)
                
                if checkWinCondition(for: .computer, in: moves) {
                    alertItem = AlertContext.Player2Win
                    return
                }
                if checkForDraw(in: moves){
                    alertItem = AlertContext.draw
                    return
                }
                
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool{
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        
        if !normalLevelOn{
            // predicting win positions
            let winPatterns:Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
            
            let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
            let computerPositions = Set(computerMoves.map { $0.boardIndex })
            
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(computerPositions)
                if winPositions.count == 1 {
                    let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                    if isAvailable { return winPositions.first! }
                }
            }
            
            // if can't win then block
            let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
            let humanPositions = Set(humanMoves.map { $0.boardIndex })
            
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(humanPositions)
                if winPositions.count == 1 {
                    let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                    if isAvailable { return winPositions.first! }
                }
            }
            
            //if AI can't win, then take middle square
            let centerSquare = 4
            if !isSquareOccupied(in: moves, forIndex: centerSquare) {
                return centerSquare
            }
            
            // if can't take middle square take random positions
            var movePosition = Int.random(in: 0..<9)
            while isSquareOccupied(in: moves, forIndex: movePosition){
                movePosition = Int.random(in: 0..<9)
            }
            return movePosition
        }
        var movePosition = Int.random(in: 0..<9)
        while isSquareOccupied(in: moves, forIndex: movePosition){
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
        
        let winPatterns:Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions){ return true }
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{ $0 }.count == 9
    }
    
    func resetGame(){
        moves = Array(repeating: nil, count: 9)
    }
}
