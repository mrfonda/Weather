//
//  CustomAlertDialogView.swift
//  Weather
//
//  Created by Vladislav Dorfman on 29/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import UIKit

class CustomAlertDialogView : UIView {
    var commentLabel: UILabel!
    var okayButton: UIButton!
    var cancelButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commentLabel = UILabel()
        okayButton = UIButton(type: .custom)
        cancelButton = UIButton(type: .custom)
        
        // TODO: Configuration such target, action, titleLable, etc. left to the user
        
        [commentLabel, okayButton, cancelButton].map { self.addSubview($0) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    @IBAction func okayButtonAction(sender: AnyObject) {
        // TODO: Complete implementation
    }
    
    @IBAction func cancelButtonAction(sender: AnyObject) {
        // TODO: Complete implementation
    }
    
}

