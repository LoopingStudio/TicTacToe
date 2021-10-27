//
//  PlayerDatas.swift
//  TicTacToe
//
//  Created by Kelian Daste on 26/10/2021.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var player1Name: String = "Joueur 1"
    var player2Name: String = "Joueur 2"
    
    var player1Wins: Int = 0
    var player2Wins: Int = 0

    
    @Published var board: [Move?] = Array(repeating: nil, count: 9)
    @Published var isPlayer1Turn = true
    @Published var isPresented = false
    
}
