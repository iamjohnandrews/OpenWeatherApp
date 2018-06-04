//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by Andrews, John L. on 6/3/18.
//  Copyright © 2018 OpenWeatherApp. All rights reserved.
//

import Foundation

struct Weather {  
  let id: Int
  var main: String
  var description: String
  
  init(id: Int,
       main: String,
       description: String) {
    self.id = id
    self.main = main
    self.description = description
  }
  
  static func retrieveWeatherObject(from json: JSONdata) -> Weather? {
    print("weather object: \(String(describing: json[Parse.weather.rawValue]))")
    guard let tempArray = json[Parse.weather.rawValue] as? [AnyObject],
      let tempDict = tempArray.first as? JSONdata,
      let id = tempDict[Parse.id.rawValue] as? Int,
      let main = tempDict[Parse.main.rawValue] as? String,
      let des = tempDict[Parse.description.rawValue] as? String
      else { return nil }
    return Weather(id: id,
                   main: main,
                   description: des)
  }
}
