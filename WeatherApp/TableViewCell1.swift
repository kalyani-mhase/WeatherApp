//
//  TableViewCell1.swift
//  WeatherApp
//
//  Created by Admin on 08/02/22.
//

import UIKit

class TableViewCell1: UITableViewCell {
    @IBOutlet weak var cityText: UILabel!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var tempText: UILabel!
    @IBOutlet weak var minTempText: UILabel!
    @IBOutlet weak var typeText: UILabel!
    @IBOutlet weak var maxTempText: UILabel!
    
    var current: CityWeatherInformation?{
        didSet{
        guard let current = current else {
            return
        }

        cityText.text = current.currentCity
       timeText.text = current.currentTime
        tempText.text = current.currentCityTemp+"°"
       minTempText.text = "L:"+current.currentMin+"°"
        maxTempText.text = "H:"+current.currentMax+"°"
        typeText.text = current.currentType
        
        if current.currentType == "Smoke"{
            //cell.view1.backgroundColor = #colorLiteral(red: 0.4444828255, green: 0.5947192464, blue: 1, alpha: 1)
            img.image = #imageLiteral(resourceName: "smoke")
        }
        else if current.currentType == "Clear"{
            img.image = #imageLiteral(resourceName: "backgroundImage")
        }
        else if current.currentType == "Clouds"{
           img.image = #imageLiteral(resourceName: "sanny")
        }
        else if current.currentType == "Haze"{
           img.image = #imageLiteral(resourceName: "haze")
        }
        else{
         img.image = #imageLiteral(resourceName: "bg3")
        }
       
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
