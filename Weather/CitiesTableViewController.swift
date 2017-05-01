//
//  CitiesTableViewController.swift
//  Weather
//
//  Created by Vladislav Dorfman on 29/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift
import Realm
import PopupDialog

class CitiesTableViewController: UITableViewController, CLLocationManagerDelegate, UITextFieldDelegate {
  
  // MARK: - ViewController's variable declarations
  
  let realm = try! Realm()
  let locationManager = CLLocationManager()
  
  var cities: Results<City> {
    get {
      let storedCities = realm.objects(City.self)
      self.navigationItem.leftBarButtonItem?.isEnabled = !storedCities.isEmpty
      return storedCities
    }
  }
  
  // MARK: - ViewController's life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Ask for current location
    if cities.isEmpty {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()
    }
    tableView.tableFooterView = UIView()
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem
  }
  
  
  // MARK: - LocationManager delegate methods
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print(locations)
    askForCurrentLocation(locations: locations)
    locationManager.stopUpdatingLocation()
    locationManager.delegate = nil
  }
  
  // MARK: - User Interaction
  
  @IBAction func addCity(_ sender: UIBarButtonItem) {
    
    let viewController = AutoCompleteViewController(nibName: "AutoCompleteViewController", bundle: nil)
    
    let popup = PopupDialog(viewController: viewController, buttonAlignment: .horizontal, transitionStyle: .bounceUp, gestureDismissal: true)
    
    let buttonCancel = CancelButton(title: "Cancel") {
    }
    
    let buttonAdd = DefaultButton(title: "Add") {
      if let city = viewController.selectedCity {
        self.addCity(city: city)
        popup.dismiss(animated: true)
      }
    }
    
    buttonAdd.dismissOnTap = false
    
    popup.addButtons([buttonCancel, buttonAdd])
    
    self.present(popup, animated: true, completion: nil)
  }
  
  fileprivate func askForCurrentLocation(locations : [CLLocation]) {
    CLGeocoder().reverseGeocodeLocation(locations[0]) { [weak self] (placemarks, error) -> Void in
      func alert() {

        let alert = UIAlertController(title: "Oops", message: "We couldn't find your location...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self?.present(alert, animated: true, completion: nil)
      
      }
      if error != nil {
        alert()
        print("Reverse geocoder failed with error" + error!.localizedDescription)
        return
      }
      
      if placemarks!.count > 0 {
        let pm = placemarks![0]
        let lat = locations[0].coordinate.latitude
        let lon = locations[0].coordinate.longitude
        let name = (pm.country != nil && pm.locality != nil) ? "\(pm.locality!), \(pm.country!)" : "\(lat), \(lon)"
        
        let alert = UIAlertController(title: "You are in \(name)", message: "Do you want to add it?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {action in
          
          let city = City()
          city.name = name
          city.lat = String(lat)
          city.lon = String(lon)
          
          self?.addCity(city: city)
          
        }))
        self?.present(alert, animated: true, completion: nil)
      }
      else {
        alert()
        print("Problem with the data received from geocoder")
      }
    }
  }
  
  // MARK: - Database operations
  
  private func addCity(city: City) {
    try! realm.write {
      realm.add(city)
      tableView.reloadData()
    }
  }
  private func deleteCity(byName: String) {
    if let cityToDelete = realm.object(ofType: City.self, forPrimaryKey: byName) {
      try! realm.write {
        realm.delete(cityToDelete)
      }
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return cities.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath)
    cell.textLabel?.text = cities[indexPath.row].name
    return cell
  }
  
  // MARK: - Table view delegate methods
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "citiesToForecast", sender: cities[indexPath.row])
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      deleteCity(byName: cities[indexPath.row].name)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let id = segue.identifier {
      switch  id {
      case "citiesToForecast":
        if let dvc = segue.destination as? ForecastCollectionViewController {
          dvc.title = (sender as! City).name
          dvc.city = sender as? City
        }
      default:
        break
      }
    }
  }
}
