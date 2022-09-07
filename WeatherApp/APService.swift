//
//  APService.swift
//  WeatherApp
//
//  Created by Admin on 04/02/22.
//

import Foundation






class ApiService{
    func getApi(cityName:String,completion : @escaping (WeatherInfo) -> ()){
        let str = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=468a926868cb745c125ffa3715888b41"
        if let url = URL(string: str){
            URLSession(configuration: .default).dataTask(with: url) { data, response, error in
                guard let data = data else {
                    return
                }
                print(data)
                let jsonDecoder = JSONDecoder()
                do{
                    let weatherData = try jsonDecoder.decode(WeatherInfo.self, from: data)
                    completion(weatherData)
                    
                }
                catch{
                    print(error.localizedDescription)
                }
                
            }.resume()
        }
    }
}
