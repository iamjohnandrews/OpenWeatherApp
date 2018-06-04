//
//  Parse.swift
//  OpenWeatherApp
//
//  Created by Andrews, John L. on 6/3/18.
//  Copyright © 2018 OpenWeatherApp. All rights reserved.
//

import Foundation

enum Parse: String {
  case list
  case main
  
  // Wind
  case speed
  case degrees = "deg"
  
  // Temperature
  case temp
  case tempMin = "temp_min"
  case tempMax = "temp_max"
  case pressure
  case seaLevel = "sea_level"
  case groundLevel = "grnd_level"
  case humidity
  case kf = "temp_kf"
  
  // Weather
  case weather
  case id
  case description
  case icon
}
