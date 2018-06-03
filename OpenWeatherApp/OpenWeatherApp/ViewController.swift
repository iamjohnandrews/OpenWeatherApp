//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Andrews, John L. on 6/1/18.
//  Copyright © 2018 OpenWeatherApp. All rights reserved.
//

import UIKit
// http://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=a2270a4ddf2ca135c28260c4d8083169
class ViewController: UIViewController {
  let sharedSession = URLSession.shared
  let apiID = "a2270a4ddf2ca135c28260c4d8083169"
  let url = URL(string: "http://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=a2270a4ddf2ca135c28260c4d8083169")!
  typealias JSONdata = [String: Any]
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }


  func getWeather() {
    let task = sharedSession.dataTask(with: url) { [unowned self] (data, response, error) in
      if let error = error {
        
      } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
        
      }
    }
    task.resume()
  }
  
  func updateModelObjects() {
    
  }
}

