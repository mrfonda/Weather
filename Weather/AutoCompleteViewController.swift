//
//  AutoCompleteViewController.swift
//  Weather
//
//  Created by Vladislav Dorfman on 29/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import UIKit
import MapKit
class AutoCompleteViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: - ViewController's variable declarations
  
  @IBOutlet weak var mapView: MKMapView!
  
  @IBOutlet weak var autoCompleteTextfield: AutoCompleteTextField!
  
  
  fileprivate var predictions : [City] = [] {
    didSet {
      if predictions.isEmpty {
        self.autoCompleteTextfield.autoCompleteStrings = nil
      } else {
        var locations = [String]()
        
        for pr in predictions{
          locations.append(pr.name)
        }
        self.autoCompleteTextfield.autoCompleteStrings = locations
      }
    }
  }
  
  public var selectedCity : City?
  
  fileprivate var selectedPointAnnotation:MKPointAnnotation?
  
  // MARK: - ViewController's life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextField()
    handleTextFieldInterfaces()
  }
  deinit {
    print("😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀")
  }
  // MARK: - Interface preparations
  
  fileprivate func configureTextField(){
    autoCompleteTextfield.delegate = self
    autoCompleteTextfield.autoCompleteTextColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    autoCompleteTextfield.autoCompleteTextFont = UIFont(name: "HelveticaNeue-Light", size: 12.0)!
    autoCompleteTextfield.autoCompleteCellHeight = 35.0
    autoCompleteTextfield.maximumAutoCompleteCount = 20
    autoCompleteTextfield.hidesWhenSelected = true
    autoCompleteTextfield.hidesWhenEmpty = true
    autoCompleteTextfield.enableAttributedText = true
    var attributes = [String:AnyObject]()
    attributes[NSForegroundColorAttributeName] = UIColor.black
    attributes[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
    autoCompleteTextfield.autoCompleteAttributes = attributes
  }
  
  
  fileprivate func handleTextFieldInterfaces(){
    autoCompleteTextfield.onTextChange = { [weak self] text in
      if !text.isEmpty{
        self?.fetchAutocompletePlaces(text)
      }
      self?.selectedCity = nil
    }
    
    autoCompleteTextfield.onSelect = { [weak self] text, indexpath in
      let coordinate = CLLocationCoordinate2D(latitude: Double((self?.predictions[indexpath.row].lat)!)!, longitude: Double((self?.predictions[indexpath.row].lon)!)!)
      self?.addAnnotation(coordinate, address: text)
      self?.mapView.setCenterCoordinate(coordinate, zoomLevel: 12, animated: true)
      self?.selectedCity = self?.predictions[indexpath.row]
    }
  }
  
  //MARK: - Private Methods
  
  fileprivate func addAnnotation(_ coordinate:CLLocationCoordinate2D, address:String?){
    if let annotation = selectedPointAnnotation {
      mapView.removeAnnotation(annotation)
    }
    
    selectedPointAnnotation = MKPointAnnotation()
    selectedPointAnnotation!.coordinate = coordinate
    selectedPointAnnotation!.title = address
    mapView.addAnnotation(selectedPointAnnotation!)
  }
  
  fileprivate func fetchAutocompletePlaces(_ keyword:String) {
    API.fetchAutocompletePredictions(query: keyword, success: { [weak self] (predictions) in
      self?.predictions = predictions
      }, fail: { [weak self] (error) in
        self?.predictions = []
    })
  }
  
  // MARK: - TextField delegate methods
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when   'return' key pressed. return NO to ignore.
  {
    textField.resignFirstResponder()
    return true;
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    autoCompleteTextfield.resignFirstResponder()
    view.endEditing(true)
  }
}
