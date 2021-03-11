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

    // create the alert
      let alert = UIAlertController(title: "Alert", message: "First choose a starting and an ending position.", preferredStyle: UIAlertController.Style.alert)

    // add an action (button)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

    // show the alert
      if (boardView.startingPosition == nil && boardView.endingPosition == nil){
          self.present(alert, animated: true, completion: nil)
      }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func resetBox(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Alert", message: "Board has been reset.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
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

