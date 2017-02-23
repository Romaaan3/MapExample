//
//  TabWeatherViewController.swift
//  MyExampleMaps
//
//  Created by Kirill on 13.02.17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit

class TabWeatherViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    var weather = DataWeatherModel()
    var longitude: Double = 0.0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        weather.downloadData {
            self.updateUI()
        }
    }

    

    func updateUI() {
        dateLabel.text = weather.date
        tempLabel.text = "\(weather.temp)"
        locationLabel.text = weather.location
        weatherLabel.text = weather.weather
        weatherImage.image = UIImage(named: weather.weather)
    }

}
