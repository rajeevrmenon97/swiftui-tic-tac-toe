//
//  PairingView.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import SwiftUI

// Main view used for discovering peers
struct PairingView: View {
    // Multipeer connectivity service
    @ObservedObject var peerService: MultiPeerService
    
    // Is this device the host?
    @State var isHost = true
    
    var body: some View {
        // Not paired yet, list the discovered peers
        if (peerService.pairingState == .notConnected) {
            if peerService.availablePeers.isEmpty {
                Text("Looking for other players nearby...")
                ProgressView()
            } else {
                List {
                    ForEach(peerService.availablePeers, id: \.self) { peer in
                        HStack {
                            Text(peer.displayName)
                        }.onTapGesture {
                            peerService.serviceBrowser.invitePeer(peer, to: peerService.session, withContext: nil, timeout: 30)
                        }
                    }
                }
                .alert("Received an invite from \(peerService.recvdInviteFrom?.displayName ?? "ERR")!", isPresented: $peerService.recvdInvite) {
                    // Accept invite button
                    Button("Accept invite") {
                        if (peerService.invitationHandler != nil) {
                            isHost = false // The other device is the host
                            peerService.invitationHandler!(true, peerService.session)
                        }
                    }
                    
                    // Reject invite button
                    Button("Reject invite") {
                        if (peerService.invitationHandler != nil) {
                            peerService.invitationHandler!(false, nil)
                        }
                    }
                }
            }
        }
        // Is paired
        else if (peerService.pairingState == .connected) {
            // Start the game with host as player1 and the guest as player 2
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
        } else {
            ProgressView()
        }
    }
}
