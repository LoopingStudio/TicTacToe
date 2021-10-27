//
//  GameView.swift
//  TicTacToe
//
//  Created by Kelian Daste on 26/10/2021.
//

import SwiftUI

struct GameView: View {
    
    
    @StateObject private var viewModel = GameViewModel()
    
    
    
    @State var presentedAlert: Alert = Alerts.player1WinAlert
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack{
                    Text(viewModel.isPlayer1Turn ? "Joueur 1, joue" : "Joueur 2, à toi")
                        .padding(.top, 32)
                        .font(.system(size: 32))
                    Spacer()
                }
                VStack {
                    Spacer()
                    LazyVGrid(columns: viewModel.columns, spacing: 4) {
                        ForEach(0..<9) { i in
                            ZStack {
                                Rectangle()
                                    .fill(Color(.systemTeal))
                                    .frame(width: geometry.size.width / 3 - 4, height: geometry.size.width / 3 - 4)
                                    .cornerRadius(16)
                                Image(systemName:  board[i]?.indicator ?? "")
                                    .resizable()
                                    .padding(20)
                                    .foregroundColor(.white)
                            }
                            .onTapGesture {
                                if isOccupied(moves: board, index: i) {
                                    return
                                }
                                board[i] = Move(isPlayer1: isPlayer1Turn, boardIndex: i)
                                
                                
                                if checkWin(player1: isPlayer1Turn, moves: board){
                                    presentedAlert = isPlayer1Turn ? Alerts.player1WinAlert : Alerts.player2WinAlert
                                    
                                    isPresented = true
                                    print("Joueur \(isPlayer1Turn ? "1" : "2") a gagné")
                                }
                                
                                if checkDraw(moves: board){
                                    presentedAlert = Alerts.drawAlert
                                    
                                    isPresented = true
                                    print("Partie finie")
                                }
                                isPlayer1Turn.toggle()
                            }
                            .alert(isPresented: $isPresented) {
                                presentedAlert
                            }
                        }
                    }
                    .padding(4)
                    Spacer()
                }
            }
        }
    }
    
    func checkWin(player1: Bool, moves: [Move?]) -> Bool{
        let patterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        let playerMoves = getCompact(board).filter { $0.isPlayer1 == player1 }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in patterns where pattern.isSubset(of: playerPositions){
            return true
        }
        return false
    }
    
    func checkDraw(moves: [Move?]) -> Bool{
        if getCompact(board).count == 9 {
            return true
        }
        return false
    }
    
    func isOccupied(moves: [Move?], index: Int) -> Bool {
        return moves.contains(where: { move in move?.boardIndex == index })
    }
    
    func getCompact(_ board: [Move?]) -> [Move] {
        return board.compactMap({ $0 })
    }
}

struct Move {
    var isPlayer1: Bool
    var boardIndex: Int
    
    var indicator: String {
        isPlayer1 ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
