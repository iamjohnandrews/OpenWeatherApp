//
//  Wind.swift
//  OpenWeatherApp
//
//  Created by Andrews, John L. on 6/3/18.
//  Copyright © 2018 OpenWeatherApp. All rights reserved.
//

import Foundation

struct Wind {
  var speed: Float
  var degrees: Float
  
  init(speed: Float, degrees: Float) {
    self.speed = speed
    self.degrees = degrees
  }
  
  static func retrieveWindObject(from json: JSONdata) -> Wind? {
    guard let tempDict = json[Parse.wind.rawValue] as? JSONdata,
      let speed = tempDict[Parse.speed.rawValue] as? Float,
      let deg = tempDict[Parse.degrees.rawValue] as? Float
      else { return nil }
    return Wind(speed: speed, degrees: deg)
  }
}
