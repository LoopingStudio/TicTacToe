//
//  Alerts.swift
//  TicTacToe
//
//  Created by Kelian Daste on 26/10/2021.
//

import Foundation
import SwiftUI

struct Alerts {
    static let player1WinAlert = Alert(title: Text("Joueur 1 a gagné !"), message: Text("Felicitations"), dismissButton: .default(Text("Rejouer")))
    static let player2WinAlert = Alert(title: Text("Joueur 3 a gagné !"), message: Text("Felicitations"), dismissButton: .default(Text("Rejouer")))
    static let drawAlert = Alert(title: Text("Égalité"), message: Text("Personne n'a gagné"), dismissButton: .default(Text("Rejouer")))
}
