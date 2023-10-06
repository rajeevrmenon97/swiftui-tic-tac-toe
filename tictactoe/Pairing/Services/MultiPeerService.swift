//
//  MultiPeerSession.swift
//  tictactoe
//
//  Created by Rajeev R Menon on 10/5/23.
//

import os
import Combine
import Foundation
import MultipeerConnectivity

class MultiPeerService: NSObject, ObservableObject {
    // Logger
    private let log = Logger()
    
    // Broadcasted service name
    private let serviceType = "rrm-tictactoe"
    
    // PeerId of this device
    let myPeerID: MCPeerID
    
    // Advertiser for the service
    public let serviceAdvertiser: MCNearbyServiceAdvertiser
    
    // Service browser to see other devices advertising
    public let serviceBrowser: MCNearbyServiceBrowser
    
    // Multipeer session object
    public let session: MCSession
    
    // Pairing state of this device
    @Published var pairingState: MCSessionState = .notConnected
    
    // List of available peers to be shown on screen
    @Published var availablePeers: [MCPeerID] = []
    
    // Boolean controlling the alert for invites
    @Published var recvdInvite: Bool = false
    
    // Peer ID of the device which invited
    @Published var recvdInviteFrom: MCPeerID? = nil
    
    // Invitation handler for received invites
    @Published var invitationHandler: ((Bool, MCSession?) -> Void)?
    
    // Passthrough object to supply moves to the game view model
    let receivedMove = PassthroughSubject<GameMove, Never>()
    
    init(playerName: String) {
        // Set the current device peer ID
        let peerID = MCPeerID(displayName: playerName)
        self.myPeerID = peerID
        
        // Initialize the session, advertiser and browser
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .none)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        super.init()
        
        // Assigne delegates
        session.delegate = self
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self
               
        // Start advertising the service
        serviceAdvertiser.startAdvertisingPeer()
        
        // Start looking for other devices
        serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        // Stop advertising
        serviceAdvertiser.stopAdvertisingPeer()
        
        // Stop looking for other devices
        serviceBrowser.stopBrowsingForPeers()
    }
    
    // Send a move to peer
    func send(move: GameMove) {
        // Check if the connected peers are not empty
        if !session.connectedPeers.isEmpty {
            do {
                // Encode the move using json encoded
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(move)
                
                // Send the move
                try session.send(jsonData, toPeers: session.connectedPeers, with: .reliable)
            } catch {
                // Error while sending the move
                log.error("Error sending move to peer: \(String(describing: error))")
            }
        }
    }
}

extension MultiPeerService: MCNearbyServiceAdvertiserDelegate {
    // Error while starting to advertise
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        log.error("Error while starting to advertise: \(String(describing: error))")
    }
    
    // Received an invite from a peer
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        DispatchQueue.main.async {
            // Inform the pairing view to show the received invite alert
            self.recvdInvite = true
            // Inform the pairing view about the peer ID of the host who sent the invite
            self.recvdInviteFrom = peerID
            // Invitation handler function to accept/reject the invitation
            self.invitationHandler = invitationHandler
        }
    }
}

extension MultiPeerService: MCNearbyServiceBrowserDelegate {
    // Error while starting to look for nearby devices
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        log.error("Error while starting to look for nearby devices: \(String(describing: error))")
    }
    
    // Discovered new peer
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        // Add the peer to the list of available peers
        // and show them in the pairing view
        DispatchQueue.main.async {
            self.availablePeers.append(peerID)
        }
    }
    
    // Peer is no longer advertising
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // Remove lost peer from list of available peers
        DispatchQueue.main.async {
            self.availablePeers.removeAll(where: {
                $0 == peerID
            })
        }
    }
}

extension MultiPeerService: MCSessionDelegate {
    // Peer changed state
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        // Update pairing state
        DispatchQueue.main.async {
            self.pairingState = state
        }
        
        
        switch state {
        case .notConnected:
            // Peer disconnected, start accepting invitaions again
            serviceAdvertiser.startAdvertisingPeer()
            break
        case .connected:
            // Paired, stop accepting invitations
            serviceAdvertiser.stopAdvertisingPeer()
            break
        default:
            break
        }
    }
    
    // Received data from peer
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
            // Decode the move into a GameMove object
            let move = try JSONDecoder().decode(GameMove.self, from: data)
            // Send the received move to game view model
            self.receivedMove.send(move)
        } catch {
            log.info("Received invalid data: \(data.count) bytes")
        }
    }
    
    // Received an input stream
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        log.error("Receiving streams is not implemented/required")
    }
    
    // Started receiving a resource
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        log.error("Receiving resources is not implemented/required")
    }
    
    // Finished receiving a resource
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        log.error("Receiving resources is not implemented/required")
    }
    
    // Received certificate
    public func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
}

