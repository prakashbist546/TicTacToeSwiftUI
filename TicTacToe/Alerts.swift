//
//  Alerts.swift
//  TicTacToe
//
//  Created by Prakash Bist on 04/05/2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin   = AlertItem(title: Text("Yay! You Win"),
                                       message: Text("You are Smart. You beat the AI"),
                                       buttonTitle: Text("Hell Yeah!"))
    
    static let computerWin = AlertItem(title: Text("You Lose"),
                                        message: Text("The AI engine is built well. You couldn't beat it"),
                                        buttonTitle: Text("Okay"))
    
    static let Player1Win = AlertItem(title: Text("Player 1 Wins"),
                                        message: Text("This player got lucky this time."),
                                        buttonTitle: Text("Go Again!"))
    
    static let Player2Win = AlertItem(title: Text("Player 2 Wins"),
                                        message: Text("This player got lucky this time."),
                                        buttonTitle: Text("Go Again!"))
    
    static let draw        = AlertItem(title: Text("It's a draw"),
                                        message: Text("Nobody wins. Looks like you both have a tough match"),
                                        buttonTitle: Text("Play Again!"))
}
