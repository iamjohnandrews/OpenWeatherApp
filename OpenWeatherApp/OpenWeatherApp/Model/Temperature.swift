//
//  Temperature.swift
//  OpenWeatherApp
//
//  Created by Andrews, John L. on 6/3/18.
//  Copyright © 2018 OpenWeatherApp. All rights reserved.
//

import Foundation

struct Temperature {  
  var temp: Float 
  var tempMin: Float
  var tempMax: Float
  var pressure: Float
  var humidity: Float
  var seaLevel: Float?
  var groundLevel: Float?
  var kf: Float?
  
  init(temp: Float,
       tempMin: Float,
       tempMax: Float,
       pressure: Float,
       humidity: Float,
       seaLevel: Float?,
       groundLevel: Float?,
       kf: Float?
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
  
  static func retrieveTemperatureObject(from json: JSONdata) -> Temperature? {
    guard let tempDict = json[Parse.main.rawValue] as? JSONdata,
      let hum = tempDict[Parse.humidity.rawValue] as? Float,
      let pres = tempDict[Parse.pressure.rawValue] as? Float,
      let temp = tempDict[Parse.temp.rawValue] as? Float,
      let max = tempDict[Parse.tempMax.rawValue] as? Float,
      let min = tempDict[Parse.tempMin.rawValue] as? Float
      else { return nil }
    return Temperature(temp: temp,
                       tempMin: min,
                       tempMax: max,
                       pressure: pres,
                       humidity: hum, 
                       seaLevel: tempDict[Parse.seaLevel.rawValue] as? Float, 
                       groundLevel: tempDict[Parse.groundLevel.rawValue] as? Float, 
                       kf: tempDict[Parse.kf.rawValue] as? Float)
  }
}
