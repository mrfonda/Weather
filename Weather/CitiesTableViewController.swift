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
    
    let realm = try! Realm()
    let locationManager = CLLocationManager()
    
    var cities: Results<City> {
        get {
            return realm.objects(City.self)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        CLGeocoder().reverseGeocodeLocation(locations[0],
                                            completionHandler: {(placemarks, error) -> Void in
                                                func alert() {
                                                    let alert = UIAlertController(title: "Oops", message: "We couldn't find your location...", preferredStyle: .alert)
                                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                                    self.present(alert, animated: true, completion: nil)
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
                                                        
                                                        try! self.realm.write {
                                                            self.realm.add(city)
                                                            self.tableView.reloadData()
                                                        }
                                                        
                                                    }))
                                                    self.present(alert, animated: true, completion: nil)
                                                }
                                                else {
                                                    alert()
                                                    print("Problem with the data received from geocoder")
                                                }
        })
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func addCity(_ sender: UIBarButtonItem) {
        
        let viewController = AutoCompleteViewController(nibName: "AutoCompleteViewController", bundle: nil)
        //self.storyboard.instantiateViewController(withIdentifier: "someViewController")
        
        let popup = PopupDialog(viewController: viewController, buttonAlignment: .horizontal, transitionStyle: .bounceUp, gestureDismissal: true)
        
        // Create first button
        let buttonCancel = CancelButton(title: "Cancel") {
        }
        
        // Create second button
        let buttonAdd = DefaultButton(title: "Add") {
            if let city = viewController.selectedCity {
                try! self.realm.write {
                    self.realm.add(city)
                    self.tableView.reloadData()
                }
                popup.dismiss(animated: true)
            }
        }
        
        buttonAdd.dismissOnTap = false
        // Add buttons to dialog
        popup.addButtons([buttonCancel, buttonAdd])
        self.present(popup, animated: true, completion: nil)
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if cities.isEmpty {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        tableView.tableFooterView = UIView()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
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
    
    private func deleteCity(byName: String) {
        if let cityToDelete = realm.object(ofType: City.self, forPrimaryKey: byName) {
            try! realm.write {
                realm.delete(cityToDelete)
            }
            if cities.isEmpty {
                self.navigationItem.leftBarButtonItem?.isEnabled = false
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        navigationItem.leftBarButtonItem?.isEnabled = true
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = cities[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "citiesToForecast", sender: cities[indexPath.row])
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete an object with a transaction
            deleteCity(byName: cities[indexPath.row].name)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
