//
//  WeatherCell.swift
//  OpenWeatherApp
//
//  Created by Andrews, John L. on 6/4/18.
//  Copyright © 2018 OpenWeatherApp. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
  @IBOutlet weak var temperature: UILabel!
  @IBOutlet weak var overview: UILabel!
  
  @IBOutlet weak var maxTemp: UILabel!
  @IBOutlet weak var minTemp: UILabel!
  @IBOutlet weak var humidity: UILabel!
  @IBOutlet weak var windSpeed: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func setContent(with weatherData: WeatherData) {
    temperature.text = String(weatherData.1.temp)
    maxTemp.text = String(weatherData.1.tempMax)
    minTemp.text = String(weatherData.1.tempMin)
    humidity.text = String(weatherData.1.humidity)
    overview.text = String(weatherData.0.description)
    windSpeed.text = String(weatherData.2.speed)
  }
}
