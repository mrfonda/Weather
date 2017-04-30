//
//  ForecastCollectionViewController.swift
//  Weather
//
//  Created by Vladislav Dorfman on 30/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import UIKit
import DateToolsSwift
private let reuseIdentifier = "dayWeather"

class ForecastCollectionViewController: UICollectionViewController {
    
    var city : City?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshRightBarItem()
    }

    
    @objc fileprivate func refreshRightBarItem() {
        if let city = city {
            
            let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            viewFN.backgroundColor = UIColor.clear
            
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            activityIndicator.startAnimating()
            activityIndicator.tintColor = UIColor.black
            viewFN.addSubview(activityIndicator)
            let rightBarButton = UIBarButtonItem(customView: viewFN)
            self.navigationItem.rightBarButtonItem = rightBarButton
            
            API.fetchObservationData(city: city, success: { (ob : Observation) in

                
                let viewFN = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
                viewFN.backgroundColor = UIColor.clear
                let button1 = UIButton(frame: CGRect(x: 0, y: 8, width: 30, height: 30))
                button1.setImage(UIImage(named: (ob.icon.replacingOccurrences(of: ".png", with: ""))), for: .normal)
                
                let button2 = UIButton(frame: CGRect(x: 20, y: 16, width: 60, height: 20))
                button2.setTitle(String(ob.tempC).appending("˚"), for: .normal)
                button2.tintColor = UIColor.black
                button2.setTitleColor(UIColor.black, for: .normal)
                
                button1.addTarget(self, action: #selector(self.refreshRightBarItem), for: .touchUpInside)
                button2.addTarget(self, action: #selector(self.refreshRightBarItem), for: .touchUpInside)
                viewFN.addSubview(button1)
                viewFN.addSubview(button2)
                
                let rightBarButton = UIBarButtonItem(customView: viewFN)
                self.navigationItem.rightBarButtonItem = rightBarButton

            }) { (error : NSError) in
                print(error)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return city?.forecast.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DayCollectionViewCell
        // let cell = collectionView.cellForItem(at: indexPath) as! DayCollectionViewCell
        if let city = city {
            cell.title.text = "\(Locale.current.calendar.weekdaySymbols[(city.forecast[indexPath.row].validTime.weekday - 1)]), \(city.forecast[indexPath.row].validTime.format(with: "dd/MM/yy") )"
            cell.icon.image = UIImage(named: (city.forecast[indexPath.row].icon.replacingOccurrences(of: ".png", with: "")))
            cell.date.text = city.forecast[indexPath.row].weatherPrimary
            cell.forecastText.text = String(describing: city.forecast[indexPath.row].minTempC).appending("˚") + " .. " + String(describing: city.forecast[indexPath.row].maxTempC).appending("˚")
        }
        
        return cell
    }
    
}
