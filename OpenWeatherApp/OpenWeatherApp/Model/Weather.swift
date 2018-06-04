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
  var icon: String
  
  init(id: Int,
       main: String,
       description: String,
       icon: String) {
    self.id = id
    self.main = main
    self.description = description
    self.icon = icon
  }
}
