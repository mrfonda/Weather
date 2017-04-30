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
