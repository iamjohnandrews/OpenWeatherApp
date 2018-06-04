# OpenWeatherApp
**Weather App** is an iOS application that displays current weather information and also a forecast for 5 days. The app utilizes [OpenWeatherMap REST API](https://api.openweathermap.org).

## Requirements

* [x]	Please read the following API - https://openweathermap.org/api. It is a free publicly available API, but you need to register/create an account to get an API Key.
* [x]	Obtain device’s coordinates and pass them to the API.
* [x]	Display the current weather information.
* [x]	Display a forecast for the next 5 days. 


The following **assumptions** were made during development:

* Want to make client dumb so that it displays whatever backend services delivers. Therefore, no filtering json data recieved.

## Implementation

* Use closure property to dynamically construct api url
* For clarity, take advantage of enums for readability in parsing, url construction, and table view section
* Make retrieving reactive to users location. Therefore if user's location changes, app automatically retrieves new weather data 
* Take advantage of extensions to organize code by creating sections
* Make code modular in order to more easily read and test

## Video Walkthrough

![](https://imgur.com/vlTKchy.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).
## Steps to build and run
* Download project from gitHub and run

## Suggestions to improve
* Error handling, both under the hood and UI (to provide user feedback)
* Add Unit Tests
* Add UI Tests
* Improve Design

