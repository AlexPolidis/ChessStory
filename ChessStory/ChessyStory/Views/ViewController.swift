//
//  ViewController.swift
//  ChessyStory
//
//  Created by Alexandros M. Polidis on 26/2/21.
//

import UIKit

class ViewController: UIViewController {
    
    var knightMoves: [Position] = []
        
    @IBOutlet weak var boardView: BoardView!
    
    @IBOutlet weak var results: BoardView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    @IBAction func showAlertButtonTapped(_ sender: UIButton) {
      let ac = UIAlertController(title: "Alert", message: "First choose a starting and an ending position.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      if (boardView.startingPosition == nil && boardView.endingPosition == nil){
          self.present(ac, animated: true)
      }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func resetBox(_ sender: UIButton) {
        
        let ac = UIAlertController(title: "Alert", message: "Board has been reset.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
        reset()
    }
    
    func reset() {
        boardView.startingPosition = nil
        boardView.endingPosition = nil
        boardView.resultString = ""
    }
    
    @IBAction func testResult(_ sender: Any) {
        resultLabel.text = "\(boardView.resultString)"
    }
    
    @IBAction func clearResults(){
        self.resultLabel.text = "Board cleared!"
    }

}

