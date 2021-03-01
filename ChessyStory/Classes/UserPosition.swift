//
//  UserPosition.swift
//  ChessyStory
//
//  Created by Alexandros M. Polidis on 26/2/21.
//

import Foundation

struct Position: Hashable {
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
   func isEqual(to position: Position) -> Bool {
        if self.x == position.x && self.y == position.y {
            return true
        }
        return false
    }
}
