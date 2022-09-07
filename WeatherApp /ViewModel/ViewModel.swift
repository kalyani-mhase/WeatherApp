//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Admin on 07/02/22.
//

import Foundation
class WeatherViewModel: NSObject {
    private(set) var cityWeatherInformation : CityWeatherInformation?{
       didSet{
           self.sendDataToController()
       }
   }
      var apiService : ApiService!
    var sendDataToController : (() -> ()) = {}
    
    override init(){
        super.init()
       
    }
     func apiCall(name:String){
        apiService.getApi(cityName: name, completion: { weatherInfo in
            self.cityWeatherInformation = CityWeatherInformation(weatherInfo: weatherInfo)
                    })
         
    }
    
    func getData1(name:String){
        self.apiService = ApiService()
        apiCall(name:name)
    }
}

struct CityWeatherInformation{
var currentCityTemp : String
var currentCity  :String
var currentMin : String
var currentMax : String
var currentDate: String
var currentTime : String
var currentSunset : String
var currentSunrise : String
var currentCountry : String
var currentPressure : String
var currentHumadity : String
var currentType : String
var currentWindspeed : String
    
    init(currentCityTemp:String,currentCity:String,currentMin:String,currentMax:String,currentDate: String,currentTime : String,currentSunset : String,currentSunrise : String,currentCountry : String,currentPressure : String,currentHumadity : String,currentType : String,currentWindspeed : String){
        self.currentCity = currentCity
        self.currentCityTemp = currentCityTemp
        self.currentMin = currentMin
        self.currentMax = currentMax
        self.currentDate = currentDate
        self.currentTime = currentTime
        self.currentSunset = currentSunset
        self.currentSunrise = currentSunrise
        self.currentCountry = currentCountry
        self.currentPressure = currentPressure
        self.currentHumadity = currentHumadity
        self.currentType = currentType
        self.currentWindspeed = currentWindspeed
    }
    
    init?(weatherInfo:WeatherInfo?){
        guard let weatherInfo = weatherInfo else {
            return nil
        }

  self.currentCity = weatherInfo.name
  self.currentType = weatherInfo.weather[0].main
  let currentT = ((weatherInfo.main.temp)-273.15).rounded(toplace: 0)
  self.currentCityTemp = String(currentT)
  self.currentMin = String(((weatherInfo.main.tempMin)-273.15).rounded(toplace: 0))
  self.currentMax = String(((weatherInfo.main.tempMax)-273.15).rounded(toplace: 0))
  let unixDate = Date(timeIntervalSince1970: Double(weatherInfo.dt))
  print(unixDate)
              let dateFormatter = DateFormatter()
              dateFormatter.dateStyle = .medium
              dateFormatter.timeStyle = .none
              let currentD = dateFormatter.string(from: unixDate)
  self.currentDate = String(currentD)
  let timeF = DateFormatter()
  timeF.timeStyle = .none
  timeF.timeStyle = .medium
  timeF.dateFormat = "h:mm a"
  let timeD = timeF.string(from: unixDate)
  print(timeD)
  self.currentTime = String(timeD)
  
  let sunset = Date(timeIntervalSince1970: Double((weatherInfo.sys.sunset)))
              let sunsetT = DateFormatter()
              sunsetT.timeStyle = .medium
              sunsetT.dateStyle = .none
              sunsetT.dateFormat = "h:mm a"
              let sunset1 = sunsetT.string(from: sunset)
  self.currentSunset = sunset1
  let sunrise = Date(timeIntervalSince1970: Double((weatherInfo.sys.sunrise)))
              let sunriseT = DateFormatter()
              sunriseT.timeStyle = .medium
              sunriseT.dateStyle = .none
              sunriseT.dateFormat = "h:mm a"
              let sunrise1 = sunriseT.string(from: sunrise)
  self.currentSunrise = sunrise1
  self.currentCountry = weatherInfo.sys.country
  self.currentPressure = String(weatherInfo.main.pressure)
  self.currentHumadity = String(weatherInfo.main.humidity)
  self.currentWindspeed = String(weatherInfo.wind.speed)
}
    
}
