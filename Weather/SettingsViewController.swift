//
//  SettingsViewController.swift
//  Weather
//
//  Created by Vladislav Dorfman on 30/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
  
  fileprivate var daysPickerView = UIPickerView()
  
  fileprivate var days = [Int]()
  
  @IBOutlet weak var daysInForecast: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    daysInForecast.text = Config.daysInForecast
    daysInForecast.addTarget(self, action: #selector(showDaysPicker), for: UIControlEvents.editingDidBegin)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(resign))
    tapGesture.cancelsTouchesInView = true
    tableView.addGestureRecognizer(tapGesture)
  }
  
  
  fileprivate func saveDays() {
    Config.daysInForecast = daysInForecast.text ?? Config.daysInForecastDefault
  }
  
  @objc fileprivate func resign() {
    tableView.endEditing(true)
  }
  
  //MARK: - preparing PickerView
  @objc fileprivate func showDaysPicker() {
    
    days = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    let daysPickerView: UIPickerView = UIPickerView()
    daysPickerView.delegate = self
    daysPickerView.dataSource = self
    daysPickerView.selectRow((Int(daysInForecast.text!)!-1), inComponent: 0, animated: false)
    daysInForecast.inputView = daysPickerView
    
  }
}

//MARK: - UIPickerView Delegate

extension SettingsViewController : UIPickerViewDelegate, UIPickerViewDataSource {
  
  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return days.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return String(describing: days[row])
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    daysInForecast.text = String(describing: days[row])
    saveDays()
  }
}
