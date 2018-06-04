//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Andrews, John L. on 6/1/18.
//  Copyright © 2018 OpenWeatherApp. All rights reserved.
//

import UIKit
import CoreLocation

typealias JSONdata = [String: AnyObject]

class ViewController: UIViewController {
  let sharedSession = URLSession.shared
  let locationManager = CLLocationManager()
  static let apiKey = "a2270a4ddf2ca135c28260c4d8083169"
  typealias Location = (Float, Float)
  
  @IBOutlet weak var tableView: UITableView!
  
  enum RequestType: String {
    case currentWeather = "weather"
    case fiveDayForecast = "forecast"
  }
  enum TableSection: Int {
    case currentWeather
    case fiveDayForecast
    case total
  }
  
  let sectionHeaderHeight: CGFloat = 30
  typealias WeatherData = (Weather, Temperature, Wind)
  var weatherDataArray = [WeatherData]()
  var weatherDataDict = [TableSection: [WeatherData]]()
  
  var currentLocation: Location? {
    didSet {
      guard oldValue?.0 != currentLocation?.0 && oldValue?.1 != currentLocation?.1  else { return }

      // When user's location changes, automatically make request for both current weather and five day forecast
      getWeather(for: .currentWeather)
      getWeather(for: .fiveDayForecast)
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
    let appKeyQuery = URLQueryItem(name: "appid", value: ViewController.apiKey)
    urlComponents.queryItems = [latQuery, longQuery, appKeyQuery]
    
    return urlComponents.url
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCoreLocation()
    setupTableView()
  }


  func getWeather(for type: RequestType) {
    guard let location = currentLocation, let url = apiURL(type.rawValue, location.0, location.1) else {
      displayErrorMessage()
      return
    }
    let task = sharedSession.dataTask(with: url) { [unowned self] (data, response, error) in
      if let error = error {
        self.handle(error)
      } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
        self.parseJSON(data, for: type)
      }
    }
    task.resume()
  }
  
  func parseJSON(_ data: Data, for type: RequestType) {
    do {
      let serializedData = try JSONSerialization.jsonObject(with: data) as! JSONdata
      
      for element in serializedData {
        print("WTF is this: \(element)")
        var weatherData: WeatherData
        if let temperature = Temperature.retrieveTemperatureObject(from: serializedData),
          let weather = Weather.retrieveWeatherObject(from: serializedData),
          let wind = Wind.retrieveWindObject(from: serializedData) {
          weatherData = WeatherData(weather, temperature, wind)
        }
        if type == .currentWeather {
          weatherDataArray.insert(weatherData, at: 0)
        } else {
          weatherDataArray.append(weatherData)
        }
      }
      
      print("What did I pull: \(serializedData)")
      
    } catch let error {
      handle(error)
      print("WTF Parsing error: \(error.localizedDescription)")
    }
  }
  
  func handle(_ error: Error) {
    // TODO: add error handling
  }
  
  func displayErrorMessage() {
    // TODO: Share error with user
  }
  
  private func setupCoreLocation() {
    self.locationManager.requestAlwaysAuthorization() 
    self.locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }
  }
  
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
}

// MARK: CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    currentLocation = Location(Float(locValue.latitude), Float(locValue.longitude))
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    handle(error)
  }
}

// MARK: TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return TableSection.total.rawValue
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : weatherDataArray.count - 1
  }
  
  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    var sectionTitle: String
    
    if let tableSection = TableSection(rawValue: section) {
      switch tableSection {
      case .currentWeather:
        sectionTitle = "Current Weather"
      case .fiveDayForecast:
        sectionTitle = "Five Day Forecast"
      default:
        sectionTitle = ""
      }
    }
    return sectionTitle
  }
  /*
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: sectionHeaderHeight))
    view.backgroundColor = UIColor.cyan
    let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: sectionHeaderHeight))
    label.font = UIFont.boldSystemFont(ofSize: 25)
    label.textColor = UIColor.black
    
    if let tableSection = TableSection(rawValue: section) {
      switch tableSection {
      case .currentWeather:
        label.text = "Current Weather"
      case .fiveDayForecast:
        label.text = "Five Day Forecast"
      default:
        label.text = ""
      }
    }
    view.addSubview(label)
    return view
  }
  */
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    <#code#>
  }
}

