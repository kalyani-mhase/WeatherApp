//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Admin on 08/02/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var cityOutlet: UILabel!
    
    @IBOutlet weak var dateOutlet: UILabel!
    
    @IBOutlet weak var timeOutlet: UILabel!
    @IBOutlet weak var minTempOutlet: UILabel!
    @IBOutlet weak var maxTempOutlet: UILabel!
    @IBOutlet weak var tempTypeOutlet: UILabel!
    
    @IBOutlet weak var cityCurrentTemp: UILabel!
    @IBOutlet weak var sunRiseOutlet: UILabel!
    
    @IBOutlet weak var sunsetOutlet: UILabel!
    @IBOutlet weak var countryOutlet: UILabel!
    @IBOutlet weak var humadityOutlet: UILabel!
    
    @IBOutlet weak var windOutlet: UILabel!
    var weatherInfo : WeatherInfo?
    @IBOutlet weak var pressuerOutlet: UILabel!
  
    var weatherView1: WeatherViewModel?{
        didSet {
            guard let cityWeatherInfo = weatherView1?.cityWeatherInformation else{
                return
            }
            cityOutlet.text = cityWeatherInfo.currentCity
            dateOutlet.text = cityWeatherInfo.currentDate
            timeOutlet.text = cityWeatherInfo.currentTime
            cityCurrentTemp.text = cityWeatherInfo.currentCityTemp
            minTempOutlet.text = "Min : "+cityWeatherInfo.currentMin
            maxTempOutlet.text = "Mix : "+cityWeatherInfo.currentMax
            tempTypeOutlet.text = cityWeatherInfo.currentType
            sunRiseOutlet.text = cityWeatherInfo.currentSunrise
            sunsetOutlet.text = cityWeatherInfo.currentSunset
            countryOutlet.text = cityWeatherInfo.currentCountry
            humadityOutlet.text = cityWeatherInfo.currentHumadity+"%"
            windOutlet.text = cityWeatherInfo.currentWindspeed+"km/h"
            pressuerOutlet.text = cityWeatherInfo.currentPressure+" hPa"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // code
      
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
