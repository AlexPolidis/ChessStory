//
//  BoardView.swift
//  ChessyStory
//
//  Created by Alexandros M. Polidis on 26/2/21.
//

import UIKit

class BoardView: UIView {
    
    var availableMoves: [Position] = []
    var nodes: [Position: Node] = [:]
    
    var resultString = ""
        
    let ratio: CGFloat = 1
    var originX: CGFloat = -10
    var originY: CGFloat = -10
    var cellSide: CGFloat = -10
    var startingPosition: Position? = nil
    var endingPosition: Position? = nil
    var N: Int = 8

        
    //Initializer για τα nodes
    func myInit(){
        for i: Int in 0...(N-1){
            
        
            for j: Int in 0...(N-1){
                let p = Position(x: i,y: j)
                nodes[p] = Node(position: p)
            }
        }
    }
    
    //Constructor
    init() {
        
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        myInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        myInit()
    }
    
    //TODO
    func changeBoardSize(){
        
        
        
    }
    
    //Ζωγραφίζει τα τετράγωνα
    override func draw(_ rect: CGRect) {
        cellSide = bounds.width * ratio / 8
        originX = bounds.width * (1 - ratio) / 2
        originY = bounds.height * (1 - ratio) / 2
        
        drawBoard()
    }
    
    //Παίρνει το startingLocation
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let start = touches.first!
        let fingerLocation = start.location(in: self)
        
        let fromCol: Int = Int((fingerLocation.x - originX) / cellSide)
        let fromRow: Int = Int((fingerLocation.y - originY) / cellSide)
        print("\(fromCol+1),\(fromRow+1)")
        addStart(startuserX: fromCol, startuserY: fromRow)
    }
        
    //Παίρνει το endingLocation
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let start = touches.first!
        let fingerLocation = start.location(in: self)
        
        let toCol: Int = Int((fingerLocation.x - originX) / cellSide)
        let toRow: Int = Int((fingerLocation.y - originY) / cellSide)
        print("to \(toCol),\(toRow)")
        addEnd(enduserX: toCol, enduserY: toRow)
    }
    
    
    func addStart(startuserX: Int, startuserY: Int){
        startingPosition = Position(x: startuserX , y: startuserY )
    }
    
    func addEnd(enduserX: Int, enduserY: Int){
        endingPosition = Position(x: enduserX , y: enduserY )
    }
    
    
    //Ζωγραφίζει ενα knight piece στο πρώτο τετράγωνο
    func drawPiece(){
        let knightPiece = UIImage(named: "Knight")
        knightPiece?.draw(in: CGRect(x: originX, y: originY, width: cellSide, height: cellSide))
    }
    
    func drawBoard() {
        //Το col ειναι για να κανει multiply τα τετραγωνα στις σωστες στηλες και το row για τις γραμμες
        for row in 0..<(N/2){
          for col in 0..<(N/2) {
              drawSquare(col: col * 2, row: row * 2, color: UIColor.white)
              drawSquare(col: 1 + col * 2, row: row * 2, color: UIColor.black)
              drawSquare(col: col * 2, row: 1 + row * 2, color: UIColor.black)
              drawSquare(col: 1 + col * 2, row: 1 + row * 2, color: UIColor.white)

            }
        }
    }
    
    //Φτιαχνει το τετράγωνο
    func drawSquare(col: Int, row: Int, color: UIColor){
        let path = UIBezierPath(rect: CGRect(x: originX + CGFloat(col) * cellSide, y: originY + CGFloat(row) * cellSide, width: cellSide, height: cellSide ))
        color.setFill()
        path.fill()
        
    }
    
    //Οι κινήσεις που μπορεί να κάνει το άλογο
    func getMoves(startingPosition: Position) -> Array<Position> {
        let knightMoves: [Position] = [
                Position(x: startingPosition.x - 2, y: startingPosition.y - 1),
                Position(x: startingPosition.x - 2, y: startingPosition.y + 1),
                Position(x: startingPosition.x - 1, y: startingPosition.y - 2),
                Position(x: startingPosition.x - 1, y: startingPosition.y + 2),
                Position(x: startingPosition.x + 1, y: startingPosition.y - 2),
                Position(x: startingPosition.x + 1, y: startingPosition.y + 2),
                Position(x: startingPosition.x + 2, y: startingPosition.y - 1),
                Position(x: startingPosition.x + 2, y: startingPosition.y + 1),
        ]
        
        
        var result: [Position] = []
        for pos in knightMoves{

            if isPositionValid(position: pos) == true
            {
                result.append(pos)
            }
        }
        return result
    }
        
    @IBAction func calculate(_ sender: UIButton) {
        if (startingPosition != nil && endingPosition != nil){
            generateMoveGraphs()
        }
        
    }
    
    func generateMoveGraphs(){
        //BFS
        func connectMovesGraph(nodes: [Position: Node] ){
            var leveledQueues = [Queue<Node>()]
            leveledQueues[0].enqueue(nodes[startingPosition!]!)

            var level = 0
            while level < leveledQueues.count && level < 3
            {
                while (leveledQueues[level].count != 0)
                {
                    let v = leveledQueues[level].dequeue()
                    for m in getMoves(startingPosition: v!.position){
                        let n = nodes[m]
                        v!.addNeighbor(node: n!)
                        n!.addNeighbor(node: v!)
                        if(leveledQueues.count == (level+1))
                        {
                            leveledQueues.append(Queue<Node>())
                        }
                        leveledQueues[level+1].enqueue(n!)
                    }
                }
                level += 1
            
            }
         }
        
        //DFS v = trexon komvos
        func recrFindPath( v: Node, depth: Int, cutoff: Int, dest: Node) -> [Node]?{
            if depth > cutoff{
               return nil
            }
//fix isequal μεσα στο Node === bugfix
           if (depth == cutoff && v === dest){
               return [v]
           }

            for n in v.neighbors{
                if var result = recrFindPath(v: n, depth: depth+1, cutoff: cutoff, dest: dest){
                  result.append(v)
                  return result
                }
            }
            return nil
        }
        
        func findPath(movesGraph: [Position: Node], cutoff: Int = 3) -> [Node]? {
            let root = movesGraph[startingPosition!]
            let dest = movesGraph[endingPosition!]
            if var path = recrFindPath(v: root!, depth: 0, cutoff: 3, dest: dest!)//epistrefei array apo nodes
            {
                path.reverse()
                return path
            }
            else{
              return nil
            }
        }
        
        let g = nodes
        for (pos, node) in g{
            node.resetNeighbors()
        }
        
        connectMovesGraph(nodes: g)
        resultString = ""
        if let path = findPath(movesGraph: g){
            for (i,v) in path.enumerated(){
                print("(\(v.position.x + 1),\(v.position.y + 1))", terminator: "")
                resultString += ("(\(v.position.x + 1),\(v.position.y + 1))")
                if (i != (path.count-1)){
                    print(" -> ", terminator: "")
                    resultString += " -> "
                }
            }
            resultString += "\n"
        }
         else{
          print("No path found.")
          resultString += "No path found.\n"
         }

    }
    
    func isPositionValid(position: Position) -> Bool {
        if position.x >= 0 && position.y >= 0 && position.x < N && position.y < N {
            return true
        }
        return false
    }

}
