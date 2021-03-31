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
        
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var sizeButton: UIButton!
    @IBOutlet weak var chessSize: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Knight Problem"
        
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        chessSize.text = "N:\(boardView.boardSize)"
        boardView.layer.borderWidth = 0.8
        boardView.layer.borderColor = UIColor.black.cgColor
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Calculate", style: .plain, target: self, action: #selector(calculate))
        resultLabel.text = "Here it will show your results!"
        resultLabel.font = .systemFont(ofSize: 20)
        
    }
    
    @objc func calculate() {
        if boardView.startingPosition != nil && boardView.endingPosition != nil {
            boardView.generateMoveGraphs()
            resultLabel.text = "\(boardView.resultString)"
        } else {
            let ac = UIAlertController(title: "Alert", message: "First choose a starting and an ending position.", preferredStyle: UIAlertController.Style.alert)
            ac.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            present(ac, animated: true)
        }
    }
    
    @objc func reset() {
        if boardView.startingPosition == nil && boardView.endingPosition == nil && boardView.boardSize == 8 {
            let ac = UIAlertController(title: "Alert", message: "There's nothing to reset.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            boardView.startingPosition = nil
            boardView.endingPosition = nil
            boardView.resultString = ""
            resultLabel.text = "Board cleared!"
            boardView.boardSize = 8
            chessSize.text = ("N:\(boardView.boardSize)")
            boardView.setNeedsDisplay()
            let ac = UIAlertController(title: "Alert", message: "Board has been reset.", preferredStyle: UIAlertController.Style.alert)
            ac.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.present(ac, animated: true)
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        boardView.boardSize = Int(sizeSlider.value)
        boardView.setNeedsDisplay()
        chessSize.text = ("N:\(Int(sizeSlider.value))")
    }
    
    
}

