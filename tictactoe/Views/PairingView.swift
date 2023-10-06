//
//  PairingView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI
import os

struct PairingView: View {
    @ObservedObject var session: MultipeerSession
    var name: String
    @Binding var displayedView: Int
    var logger = Logger()
    var oppName = ""
    
    var body: some View {
        if (!session.paired) {
            HStack {
                List(session.availablePeers, id: \.self) { peer in
                    Button(peer.displayName) {
                        session.serviceBrowser.invitePeer(peer, to: session.session, withContext: nil, timeout: 30)
                    }
                }
            }
            .alert("Received an invite from \(session.recvdInviteFrom?.displayName ?? "ERR")!", isPresented: $session.recvdInvite) {
                Button("Accept invite") {
                    if (session.invitationHandler != nil) {
                        session.invitationHandler!(true, session.session)
                    }
                }
                Button("Reject invite") {
                    if (session.invitationHandler != nil) {
                        session.invitationHandler!(false, nil)
                    }
                }
            }
        } else {
            GameView(gameViewModel: GameViewModel(
                player1: Player(name: name, symbol: .cross),
                player2: Player(name: session.recvdInviteFrom?.displayName ?? "Player 2", symbol: .circle)
            ), displayedView: $displayedView)
        }
    }
}
