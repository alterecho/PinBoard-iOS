//
//  LoadIndicator.swift
//  PinBoard
//
//  Created by echo on 7/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import UIKit

class LoadIndicator : UIActivityIndicatorView {
    var isLoading: Bool = false {
        didSet {
            //            loadIndicator.isHidden = !isLoading
            let startBGColor: UIColor
            let endBGColor: UIColor
            let completionBlock: () -> ()
            if isLoading {
                self.startAnimating()
                self.isHidden = false
                startBGColor = UIColor.clear
                endBGColor = UIColor.black.withAlphaComponent(0.5)
                completionBlock = { [weak self] in
                    self?.backgroundColor = endBGColor
                }
            } else {
                self.stopAnimating()
                self.startAnimating()
                startBGColor = UIColor.black.withAlphaComponent(0.5)
                endBGColor = UIColor.clear
                
                completionBlock = { [weak self] in
                    self?.backgroundColor = endBGColor
                    self?.stopAnimating()
                    self?.isHidden = true
                }
            }
            
            self.backgroundColor = startBGColor
            UIView.animate(withDuration: 1.0, animations: { [weak self] in
                self?.backgroundColor = endBGColor
            }) { (completed) in
                completionBlock()
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
