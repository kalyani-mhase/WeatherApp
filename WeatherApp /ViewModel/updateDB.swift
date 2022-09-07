//
//  updateDB.swift
//  WeatherApp
//
//  Created by Admin on 17/02/22.
//

import Foundation
import UIKit
protocol UpdationProtocol:AnyObject{
    func passInfo()
}
class updataion{
    var cityInfoUpdated : [CityWeatherInformation]?
 
    var counter = Int()
    var no : Int = 1
    weak var delegate : UpdationProtocol?
    var model = [WeatherInfo]()
    var dbHelper = DBHelper()
    init(){
        updateDB()
        
       
    }
    func updateDB(){
        var cityWeatherInformation1 : [CityWeatherInformation]?
        guard let cityWeatherInformation = dbHelper.displayWeather() else{
            return
        }
        var data : String = ""
    cityWeatherInformation1 = cityWeatherInformation
        
        print(cityWeatherInformation.count)

        while counter < cityWeatherInformation.count{
            data = cityWeatherInformation[counter].currentCity
            print(cityWeatherInformation[counter].currentCity)
            counter = counter+1
           
            break
        }
        
        ApiService().getApi(cityName: data) { weatherInfo in
            
           // self.model.append(weatherInfo)
            DispatchQueue.main.async {
                guard let  cityInfo = CityWeatherInformation(weatherInfo: weatherInfo) else{
                    return
                }
                self.dbHelper.updateWeather(cityName: cityInfo.currentCity, cityWeatherInfo: cityInfo)
                if self.no <=  cityWeatherInformation.count{
                    self.updateDB()
                    self.no = self.no+1
                    if self.no > cityWeatherInformation.count{
                        self.updateDatabase()
                        self.delegate?.passInfo()
                    }
            }
                
            }
           
        }
    }

    func updateDatabase(){
        
        guard let cityInfoUpdated = dbHelper.displayWeather()else{
            return
        }
        self.cityInfoUpdated = cityInfoUpdated
    }
    func addBtn(){
    
}
}
extension updataion: WeatherInfoProtocol1{
    func passInfo(cityWeatherInfoFromAPI: CityWeatherInformation?) {
        guard let cityWeatherInformation1 = DBHelper().displayWeather() else{
             return
         }
         self.cityInfoUpdated = cityWeatherInformation1
        delegate?.passInfo()
    }
    
    
}
