//
//  Temperature.swift
//  OpenWeatherApp
//
//  Created by Andrews, John L. on 6/3/18.
//  Copyright © 2018 OpenWeatherApp. All rights reserved.
//

import Foundation

struct Temperature {
  enum Parse: String {
    case temp
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure
    case seaLevel = "sea_level"
    case groundLevel = "grnd_level"
    case humidity
    case kf = "temp_kf"
  } 
  
  var temp: Float 
  var tempMin: Float
  var tempMax: Float
  var pressure: Float
  var seaLevel: Float
  var groundLevel: Float
  var humidity: Float
  var kf: Float
  
  init(temp: Float,
       tempMin: Float,
       tempMax: Float,
       pressure: Float,
       seaLevel: Float,
       groundLevel: Float,
       humidity: Float,
       kf: Float
    ) {
    self.temp = temp
    self.tempMin = tempMin
    self.tempMax = tempMax
    self.pressure = pressure
    self.seaLevel = seaLevel
    self.groundLevel = groundLevel
    self.humidity = humidity
    self.kf = kf
  }
}
