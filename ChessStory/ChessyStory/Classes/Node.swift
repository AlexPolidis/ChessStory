//
//  Node.swift
//  ChessyStory
//
//  Created by Alexandros M. Polidis on 27/2/21.
//

import Foundation

class Node {
    let position: Position // (x, y) represents chessboard coordinates
    var neighbors: [Node]
    
    func addNeighbor(node: Node){
     neighbors.append(node)
    }
    
    func resetNeighbors(){
        neighbors = []
    }
    
    
    init(position: Position) {
        self.position = position
        neighbors = []
    }
    
    
    
}

