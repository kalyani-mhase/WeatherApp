//
//  ViewController.swift
//  WeatherApp
//
//  Created by Admin on 04/02/22.
//

import UIKit
import CoreLocation
//
//MARK: WeatherInfoProtocol
//
protocol WeatherInfoProtocol: AnyObject {
    func passInfo(cityWeatherInfoFromAPI: CityWeatherInformation?)
}

class NextViewController: UIViewController,CLLocationManagerDelegate{
   
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var currentCityTemp: UILabel!
    @IBOutlet weak var bgIamge: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var sunriseOutlet: UILabel!
    @IBOutlet weak var sunsetOutlet: UILabel!
    @IBOutlet weak var humadityOutlet: UILabel!
    @IBOutlet weak var contryOutlet: UILabel!
    @IBOutlet weak var windOutlet: UILabel!
    @IBOutlet weak var pressureOutlet: UILabel!
    @IBOutlet weak var minOutlet: UILabel!
    @IBOutlet weak var maxOutlet: UILabel!
    @IBOutlet weak var celciusOutlet: UILabel!
    @IBOutlet weak var sunrise1: UILabel!
    @IBOutlet weak var sunset1: UILabel!
    @IBOutlet weak var country1: UILabel!
    @IBOutlet weak var pressure1: UILabel!
    @IBOutlet weak var humadity1: UILabel!
    @IBOutlet weak var wind1: UILabel!
    @IBOutlet weak var addOutlet: UIButton!
    @IBOutlet weak var cancelOutlet: UIButton!
    
    var controlVar : Bool?
    var weatherViewModel : WeatherViewModel!
    var cityName : String?
    var row: Bool?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate : WeatherInfoProtocol?
    var cityWeatherInfo : CityWeatherInformation?
    var cityWeatherInformation : CityWeatherInformation?
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        accessToUI(temp: true)
        dataFromApi(name: cityName!)
        nameLbl.text = cityName
          }
    
    //
    //MARK: API call
     private func dataFromApi(name:String){
         
             self.weatherViewModel = WeatherViewModel()
         self.weatherViewModel.getData1(name: name)
             weatherViewModel!.sendDataToController = {
                 DispatchQueue.main.async { [self] in
                     self.activityIndicator.isHidden = true
                     guard let currentTemp = self.weatherViewModel.cityWeatherInformation else{
                         return
                     }
                     self.cityWeatherInformation = currentTemp
                     if controlVar!{
                        
                         self.activityIndicator.isHidden = true
                     self.setWeatherInformation(currentTemp)
                         
                     }
                     else{
                         addOutlet.titleLabel?.text = " "
                         self.setWeatherInformation(currentTemp)
                     }
                 }
           }
     }
    //MARK: cnacelBtn action
    @IBAction func cancelBtnAction(_ sender: Any) {
        if controlVar!{
            self.dismiss(animated: true)
        }
        else{
        self.dismiss(animated: true)
        //addOutlet.isHidden = true
     
        DBHelper().updateWeather(cityName: cityWeatherInformation!.currentCity, cityWeatherInfo: cityWeatherInformation!)
            
        delegate?.passInfo(cityWeatherInfoFromAPI: cityWeatherInformation)
    }
    }
    func showAlert(title: String, mssg: String, _ navigateBack: Bool = false){
        let alert = UIAlertController(title: title, message: mssg, preferredStyle: .alert)
    
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self]_ in
                self.delegate?.passInfo(cityWeatherInfoFromAPI: self.cityWeatherInformation)
               
                self.dismiss(animated: true)
            }))
        
        present(alert, animated: true, completion: nil)
    }
    //MARK: AddAction
    @IBAction func addAction(_ sender: Any) {
       let dbHelper = DBHelper()
        guard let cityWeatherInformation = cityWeatherInformation else {
            return
        }
        if controlVar!{
            addOutlet.titleLabel?.text = "Add"
            dbHelper.insertWeatherInfo(cityWeatherInfo:cityWeatherInformation) { title, msg in
               showAlert(title: title, mssg: msg)
            } failureClosure: { title, msg in
                showAlert(title: title, mssg: msg)
            }
        }
        
    }
    func accessToUI(temp:Bool){
        minOutlet.isHidden = temp
        maxOutlet.isHidden = temp
        currentCityTemp.isHidden = temp
        weatherType.isHidden = temp
        date.isHidden = temp
        timelbl.isHidden = temp
        sunriseOutlet.isHidden = temp
        sunsetOutlet.isHidden = temp
        humadityOutlet.isHidden = temp
        contryOutlet.isHidden = temp
        windOutlet.isHidden = temp
        sunset1.isHidden = temp
        sunrise1.isHidden = temp
        humadity1.isHidden = temp
        wind1.isHidden = temp
        pressure1.isHidden = temp
        celciusOutlet.isHidden = temp
        img.isHidden = temp
        country1.isHidden = temp
        addOutlet.isHidden = temp
       //cancelOutlet.isHidden = temp
        pressureOutlet.isHidden = temp
        activityIndicator.isHidden = !temp
        
    }
    
    
    fileprivate func setWeatherInformation(_ currentTemp: CityWeatherInformation) {
        self.nameLbl.text = cityName
        accessToUI(temp: false)
        addOutlet.isHidden = false
        self.activityIndicator.isHidden = true
        self.weatherType.text = currentTemp.currentType
        self.date.text = currentTemp.currentDate
        self.timelbl.text = currentTemp.currentTime
        self.currentCityTemp.text = currentTemp.currentCityTemp
        self.minOutlet.text = "Min : "+currentTemp.currentMin
        self.maxOutlet.text = "Mix : "+currentTemp.currentMax
        self.weatherType.text = currentTemp.currentType
        self.sunsetOutlet.text = currentTemp.currentSunset
        self.sunriseOutlet.text = currentTemp.currentSunrise
        self.contryOutlet.text = currentTemp.currentCountry
        self.humadityOutlet.text = currentTemp.currentHumadity+"%"
        self.windOutlet.text = currentTemp.currentWindspeed + "km/h"
        self.pressureOutlet.text = currentTemp.currentPressure + "hPa"
        self.cityWeatherInformation = currentTemp
    }
   
   
}




