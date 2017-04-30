//
//  SettingsViewController.swift
//  Weather
//
//  Created by Vladislav Dorfman on 30/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        daysInForecast.text = Config.daysInForecastDefault
        daysInForecast.delegate = self
    }
    @IBOutlet weak var daysInForecast: UITextField!

    func saveDays() {
        Config.daysInForecast = daysInForecast.text ?? Config.daysInForecastDefault
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveDays()
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when   'return' key pressed. return NO to ignore.
    {
        daysInForecast?.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        daysInForecast?.resignFirstResponder()
    }


}
