//
//  CustomAlertController.swift
//  Weather
//
//  Created by Vladislav Dorfman on 29/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import UIKit


class CustomAlertDialogViewCongroller : UIViewController {
    override func loadView() {
        self.view = CustomAlertDialogView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
    }
}
