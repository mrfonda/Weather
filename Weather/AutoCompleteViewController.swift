//
//  AutoCompleteViewController.swift
//  Weather
//
//  Created by Vladislav Dorfman on 29/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import UIKit
import GoogleMaps
class AutoCompleteViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: - ViewController's variable declarations
  
  @IBOutlet weak var mapView: GMSMapView!
  
  @IBOutlet weak var autoCompleteTextfield: AutoCompleteTextField!
  
  
  var locationManager : CLLocationManager?

  let marker = GMSMarker()
  
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
  
  fileprivate var selectedPointAnnotation: GMSMarker?
  
  // MARK: - ViewController's life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextField()
    handleTextFieldInterfaces()
    prepareLocationManager()
  }
  
  override func viewWillDisappear(_ animated:Bool){
    super.viewWillDisappear(animated)
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
      self?.showMarker(coordinate, address: text)
      self?.mapView.animate(toLocation: coordinate)
      self?.mapView.animate(toZoom: 12.0)
      self?.selectedCity = self?.predictions[indexpath.row]
      }
  }
  
  //MARK: - Private Methods
  
  fileprivate func prepareLocationManager() {
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    locationManager?.requestWhenInUseAuthorization()
    locationManager?.startUpdatingLocation()
  }
  
  fileprivate func showMarker(_ coordinate:CLLocationCoordinate2D, address:String?){
    marker.position = coordinate
    marker.title = address
    if marker.map == nil {
      marker.map = mapView
    }
  }
  fileprivate func showCurrentLocation(locations: [CLLocation]) {
    if !locations.isEmpty {
    mapView.animate(toLocation: locations[0].coordinate)
    mapView.animate(toZoom: 12.0)
    }
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
extension AutoCompleteViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    showCurrentLocation(locations: locations)
    locationManager?.stopUpdatingLocation()
    locationManager?.delegate = nil
    locationManager = nil
  }
}
