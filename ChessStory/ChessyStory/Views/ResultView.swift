//
//  resultView.swift
//  ChessyStory
//
//  Created by Alexandros M. Polidis on 28/2/21.
//

import UIKit
class resultView: UIView {
    
    let nibName = "resultView"
    var contentView:UIView?

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    /*@IBAction func DiplayResults(){
        self.label.text = "SHOW ME RESULTS"
    }
    
    @IBAction func clearResults(){
        self.label.text = "Here it will display your results."
    }*/

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
