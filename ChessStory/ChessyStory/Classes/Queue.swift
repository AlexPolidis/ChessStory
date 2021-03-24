//
//  Queue.swift
//  ChessyStory
//
//  Created by Alexandros M. Polidis on 27/2/21.
//

import Foundation

struct Queue<T>{
    
    private var elements: [T] = []
    public init() {}
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var peek: T?{
        elements.first
    }
    
    mutating func enqueue(_ value: T){
        elements.append(value)
    }
    
    mutating func dequeue() -> T?{
        isEmpty ? nil : elements.removeFirst()
        
    }
    
    var count: Int {
        elements.count
    }
    
}
