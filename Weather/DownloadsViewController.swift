//
//  DownloadsViewController.swift
//  Weather
//
//  Created by Vladislav Dorfman on 29/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import UIKit
import RealmSwift


class DownloadsViewController: UIViewController {
    
    let realm = try! Realm()
    
    var cities: Results<City> {
        get {
            return realm.objects(City.self)
        }
    }
    
    @IBOutlet weak var downloadingProgressView: UIProgressView!
    
    @IBOutlet weak var downloadButton: UIButton!
    
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        downloadingProgressView.progress = 0.0
        fetchForecast(cities: Array(cities))
        sender.isEnabled = false
    }
    func finishedDownload() {
        self.downloadButton.isEnabled = true
        downloadingProgressView.progress = 100.0
    }
    
    func fetchForecast(cities: [City]) {
        if let city = cities.first {
            let recCities = Array(cities.dropFirst())
            API.fetchForecastData(city: city, success: { [weak self] in
                self?.fetchForecast(cities: recCities)
            }, fail: { [weak self] (error : NSError) in
                print(error)
                self?.fetchForecast(cities: recCities)
            }, updateProgress: { [weak self] (progress : Float) in
            self?.downloadingProgressView.setProgressSegmented(segmentNumber: (self?.cities.count)! - cities.count, segmentProgress: progress, numberOfSegments: (self?.cities.count)!)
            })
        } else {
            finishedDownload()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension UIProgressView {
    func setProgressSegmented(segmentNumber : Int, segmentProgress : Float, numberOfSegments : Int) {
        let progressSegmented = Float(Float(segmentNumber) + segmentProgress)/Float(numberOfSegments)
        setProgress(progressSegmented, animated: true)
    }
}
