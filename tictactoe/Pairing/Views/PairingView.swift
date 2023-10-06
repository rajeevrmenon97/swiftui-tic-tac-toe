//
//  PairingView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

struct PairingView: View {
    @ObservedObject var peerService: MultiPeerService
    @Binding var displayedView: Int
    @State var isHost = true
    
    var body: some View {
        if (!peerService.paired) {
            HStack {
                List(peerService.availablePeers, id: \.self) { peer in
                    Button(peer.displayName) {
                        peerService.serviceBrowser.invitePeer(peer, to: peerService.session, withContext: nil, timeout: 30)
                    }
                }
            }
            .alert("Received an invite from \(peerService.recvdInviteFrom?.displayName ?? "ERR")!", isPresented: $peerService.recvdInvite) {
                Button("Accept invite") {
                    if (peerService.invitationHandler != nil) {
                        isHost = false
                        peerService.invitationHandler!(true, peerService.session)
                    }
                }
                Button("Reject invite") {
                    if (peerService.invitationHandler != nil) {
                        peerService.invitationHandler!(false, nil)
                    }
                }
            }
        } else {
            if isHost {
                GameView(
                    gameViewModel: GameViewModel(
                        player1: Player(name: peerService.myPeerID.displayName, symbol: .cross),
                        player2: Player(name: peerService.recvdInviteFrom?.displayName ?? "Player 2", symbol: .circle),
                        isMultiPeer: true,
                        peerService: peerService,
                        isHost: isHost
                    )
                )
            } else {
                GameView(
                    gameViewModel: GameViewModel(
                        player1: Player(name: peerService.recvdInviteFrom?.displayName ?? "Player 2", symbol: .cross),
                        player2: Player(name: peerService.myPeerID.displayName, symbol: .circle),
                        isMultiPeer: true,
                        peerService: peerService,
                        isHost: isHost
                    )
                )
            }
        }
    }
}
