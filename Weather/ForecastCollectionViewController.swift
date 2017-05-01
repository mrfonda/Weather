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
  
  // refreshRightBarItem - adding and refreshing current weather view to rightBarButton
  @objc fileprivate func refreshRightBarItem() {
    if let city = city {
      
      var currentWeatherView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
      currentWeatherView.backgroundColor = UIColor.clear
      
      let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
      activityIndicator.startAnimating()
      activityIndicator.color = UIColor.black
      currentWeatherView.addSubview(activityIndicator)
      
      let rightBarButton = UIBarButtonItem(customView: currentWeatherView)
      self.navigationItem.rightBarButtonItem = rightBarButton
      
      API.fetchObservationData(city: city, success: { [weak self] (ob : Observation) in
        
        
        currentWeatherView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        currentWeatherView.backgroundColor = UIColor.clear
        let icon = UIButton(frame: CGRect(x: 0, y: 8, width: 30, height: 30))
        icon.setImage(UIImage(named: (ob.icon.replacingOccurrences(of: ".png", with: ""))), for: .normal)
        
        let temperature = UIButton(frame: CGRect(x: 20, y: 16, width: 60, height: 20))
        temperature.setTitle(String(ob.tempC).appending("˚"), for: .normal)
        temperature.tintColor = UIColor.black
        temperature.setTitleColor(UIColor.black, for: .normal)
        
        icon.addTarget(self, action: #selector(self?.refreshRightBarItem), for: .touchUpInside)
        temperature.addTarget(self, action: #selector(self?.refreshRightBarItem), for: .touchUpInside)
        currentWeatherView.addSubview(icon)
        currentWeatherView.addSubview(temperature)
        
        let rightBarButton = UIBarButtonItem(customView: currentWeatherView)
        self?.navigationItem.rightBarButtonItem = rightBarButton
        
      }) { (error : NSError) in
        print(error)
      }
    }
  }
  
  // MARK: - UICollectionViewDataSource
  
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
      cell.forecastText.text = city.forecast[indexPath.row].weatherPrimary
      cell.temparatures.text = String(describing: city.forecast[indexPath.row].minTempC).appending("˚") + " .. " + String(describing: city.forecast[indexPath.row].maxTempC).appending("˚")
    }
    return cell
  }
}
