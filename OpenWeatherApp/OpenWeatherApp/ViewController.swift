//
//  NetworkingViewController.swift
//  OpenWeatherApp
//
//  Created by Andrews, John L. on 6/1/18.
//  Copyright © 2018 OpenWeatherApp. All rights reserved.
//

import UIKit
import CoreLocation

// http://samples.openweathermap.org/data/2.5/forecast?id=524901&appid=a2270a4ddf2ca135c28260c4d8083169
enum RequestType: String {
  case currentWeather = "weather"
  case fiveDayForecast = "forecast"
}
class NetworkingViewController: UIViewController {
  let sharedSession = URLSession.shared
  let locationManager = CLLocationManager()
  static let apiKey = "a2270a4ddf2ca135c28260c4d8083169"

  typealias JSONdata = [String: Any]
  typealias Location = (Float, Float)
//  let currentWeatherAPI = "api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}"
//  let fiveDayForecastAPI = "api.openweathermap.org/data/2.5/forecast?lat=35&lon=139"
  
  var currentLocation: Location? {
    didSet {
      guard oldValue?.0 != currentLocation?.0 && oldValue?.1 != currentLocation?.1  else { return }
      
      // When user's location changes, automatically make request for both current weather and five day forecast
      getWeather(for: .currentWeather)
//      getWeather(for: .fiveDayForecast)
    }
  } 
  let apiURL: (String, Float, Float) -> URL? = { 
    type, lat, long in 
    
    let urlComponents = NSURLComponents()
    urlComponents.scheme = "http";
    urlComponents.host = "api.openweathermap.org";
    urlComponents.path = "/data/2.5/\(type)";
    
    let latQuery = URLQueryItem(name: "lat", value: String(lat))
    let longQuery = URLQueryItem(name: "lon", value: String(long))
    let appKeyQuery = URLQueryItem(name: "appid", value: NetworkingViewController.apiKey)
    urlComponents.queryItems = [latQuery, longQuery, appKeyQuery]
    
    return urlComponents.url
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.locationManager.requestAlwaysAuthorization() 
    self.locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }
  }


  func getWeather(for type: RequestType) {
    guard let location = currentLocation, let url = apiURL(type.rawValue, location.0, location.1) else {
      displayErrorMessage()
      return
    }
    let task = sharedSession.dataTask(with: url) { [unowned self] (data, response, error) in
      if let error = error {
        self.handle(error)
        print("WTF Network error: \(error.localizedDescription)")
      } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
        self.parseJSON(data, for: type)
      }
    }
    task.resume()
  }
  
  func parseJSON(_ data: Data, for type: RequestType) {
    do {
      let serializedData = try JSONSerialization.jsonObject(with: data) as! JSONdata
      print("What did I pull: \(serializedData)")
      
    } catch let error {
      handle(error)
      print("WTF Parsing error: \(error.localizedDescription)")
    }
  }
  
  func handle(_ error: Error) {
    // TODO: add alert
  }
  
  func displayErrorMessage() {
    
  }
}

extension NetworkingViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//    print("locations = \(locValue.latitude) \(locValue.longitude)")
    currentLocation = Location(Float(locValue.latitude), Float(locValue.longitude))
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Locating error: \(error.localizedDescription)")
  }
}

